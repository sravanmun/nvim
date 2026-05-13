-- Small lazy-loading helper on top of vim.pack (Neovim 0.12+).
--
-- Usage: see init.pack.lua. Each spec resembles a lazy.nvim spec, but the
-- trigger surface is intentionally smaller: eager, cmd, keys, event, ft.
--
-- Mechanics:
--   * All specs are batched and installed in a single vim.pack.add() at the end
--     of init, so cloning is parallel and the lockfile stays consistent.
--   * Eager specs are :packadd-ed once installation finishes, then setup runs.
--   * Lazy specs register stubs (user commands, keymaps, autocmds). On first
--     trigger the stub :packadds the plugin, runs setup, and re-dispatches.

local M = {}

local function plugin_name(src)
  return src:match("([^/]+)%.git$") or src:match("([^/]+)$")
end

local function strip_suffix(name)
  return (name:gsub("%.git$", ""))
end

-- Per-spec record after normalization.
---@class PackSpec
---@field src string
---@field name string
---@field version string|nil
---@field module string|nil       -- lua module to require for setup (defaults to name minus common suffixes)
---@field opts table|fun():table|nil
---@field config fun()|nil        -- arbitrary setup function (overrides opts)
---@field cmd string|string[]|nil
---@field keys table|nil
---@field event string|string[]|nil
---@field ft string|string[]|nil

local eager_specs = {}        ---@type PackSpec[]
local lazy_specs = {}         ---@type PackSpec[]
local eager_setups = {}       ---@type fun()[]
local loaded = {}             ---@type table<string, boolean>

local function as_list(v)
  if v == nil then return {} end
  if type(v) == "string" then return { v } end
  return v
end

local function infer_module(name)
  -- Strip common suffixes so "gitsigns.nvim" -> "gitsigns".
  return (name:gsub("%.nvim$", ""):gsub("%.lua$", ""):gsub("%-nvim$", ""))
end

local function run_setup(spec)
  if spec.config then
    spec.config()
    return
  end
  if spec.opts ~= nil then
    local mod_name = spec.module or infer_module(spec.name)
    local ok, mod = pcall(require, mod_name)
    if not ok then
      vim.notify(("pack_load: cannot require '%s' for %s"):format(mod_name, spec.name), vim.log.levels.WARN)
      return
    end
    local opts = type(spec.opts) == "function" and spec.opts() or spec.opts
    mod.setup(opts)
  end
end

local function load_plugin(spec)
  if loaded[spec.name] then return end
  loaded[spec.name] = true
  -- For lazy plugins we deferred install too — vim.pack.add here will install
  -- on first trigger if missing, otherwise it's a no-op + :packadd that
  -- sources plugin/ files.
  vim.pack.add({ { src = spec.src, name = spec.name, version = spec.version } },
    { confirm = false })
  -- vim.pack.add already :packadds after init, but be explicit for clarity.
  pcall(vim.cmd.packadd, spec.name)
  run_setup(spec)
end

-- Public: register a spec. Lazy.nvim-style shape.
function M.add(spec)
  assert(type(spec) == "table", "pack_load.add: spec must be a table")
  local src = spec[1] or spec.src
  assert(src, "pack_load.add: missing src (positional [1] or `src`)")
  if not src:match("^https?://") and src:match("/") then
    src = "https://github.com/" .. src
  end
  local name = spec.name or strip_suffix(plugin_name(src))
  local norm = {
    src = src,
    name = name,
    version = spec.version,
    module = spec.module,
    opts = spec.opts,
    config = spec.config,
    cmd = spec.cmd,
    keys = spec.keys,
    event = spec.event,
    ft = spec.ft,
  }

  local is_lazy = spec.cmd or spec.keys or spec.event or spec.ft or spec.lazy
  if not is_lazy then
    table.insert(eager_specs, norm)
    table.insert(eager_setups, function() load_plugin(norm) end)
    return
  end
  table.insert(lazy_specs, norm)

  -- Lazy: register triggers.

  -- Commands
  for _, cmd in ipairs(as_list(spec.cmd)) do
    vim.api.nvim_create_user_command(cmd, function(args)
      vim.api.nvim_del_user_command(cmd)
      load_plugin(norm)
      vim.cmd(string.format("%s%s %s",
        args.bang and "!" or "",
        cmd,
        args.args or ""))
    end, { nargs = "*", bang = true, complete = "file" })
  end

  -- Keys: shape mirrors lazy.nvim: { lhs, rhs_or_fn, mode = ?, desc = ? }
  for _, k in ipairs(spec.keys or {}) do
    local lhs = k[1]
    local rhs = k[2]
    local mode = k.mode or "n"
    vim.keymap.set(mode, lhs, function()
      -- Remove all stubs for this plugin so subsequent uses go straight through.
      -- (Simpler: just rely on `loaded` flag and load_plugin idempotency.)
      load_plugin(norm)
      if type(rhs) == "function" then
        rhs()
      elseif type(rhs) == "string" then
        -- Feed keys so the real plugin's mapping runs.
        local feed = vim.api.nvim_replace_termcodes(rhs, true, false, true)
        vim.api.nvim_feedkeys(feed, "m", false)
      end
    end, { desc = k.desc, silent = true })
  end

  -- Events: BufReadPost / BufNewFile / VeryLazy / etc.
  local events = as_list(spec.event)
  if #events > 0 then
    local group = vim.api.nvim_create_augroup("PackLoad_" .. name, { clear = true })
    for _, ev in ipairs(events) do
      if ev == "VeryLazy" then
        vim.api.nvim_create_autocmd("User", {
          group = group, pattern = "PackLoadVeryLazy", once = true,
          callback = function() load_plugin(norm) end,
        })
      else
        vim.api.nvim_create_autocmd(ev, {
          group = group, once = true,
          callback = function() load_plugin(norm) end,
        })
      end
    end
  end

  -- Filetypes
  local fts = as_list(spec.ft)
  if #fts > 0 then
    vim.api.nvim_create_autocmd("FileType", {
      pattern = fts,
      once = true,
      callback = function() load_plugin(norm) end,
    })
  end
end

-- Public: install eager plugins + run eager setups. Call once at end of init.
-- Lazy plugins are NOT installed here — they're installed on first trigger
-- (via vim.pack.add in load_plugin). To pre-install them, run :PackSync.
function M.commit()
  local install_specs = {}
  for _, s in ipairs(eager_specs) do
    table.insert(install_specs, { src = s.src, name = s.name, version = s.version })
  end
  vim.pack.add(install_specs, { confirm = false })

  for _, fn in ipairs(eager_setups) do
    fn()
  end

  -- :PackSync — install every registered lazy plugin without loading it.
  -- Useful on a fresh machine to avoid stalls on first keymap/command.
  vim.api.nvim_create_user_command("PackSync", function()
    local pending = {}
    for _, s in ipairs(lazy_specs) do
      if not loaded[s.name] then
        table.insert(pending, { src = s.src, name = s.name, version = s.version })
      end
    end
    if #pending == 0 then
      vim.notify("PackSync: nothing to install", vim.log.levels.INFO)
      return
    end
    vim.pack.add(pending, { confirm = false })
    vim.notify(("PackSync: installed %d plugin(s)"):format(#pending), vim.log.levels.INFO)
  end, {})

  -- Fire VeryLazy after UI is shown.
  vim.api.nvim_create_autocmd("UIEnter", {
    once = true,
    callback = function()
      vim.schedule(function()
        vim.api.nvim_exec_autocmds("User", { pattern = "PackLoadVeryLazy" })
      end)
    end,
  })
end

return M
