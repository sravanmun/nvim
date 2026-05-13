-- init.lua using vim.pack.

-- Built-in Lua bytecode cache (~/.cache/nvim/luac).
vim.loader.enable()

-- leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- disable netrw (nvim-tree replaces it)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- disable unused providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- terminal background sync
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    local bg = vim.fn.synIDattr(vim.fn.hlID("Normal"), "bg")
    if bg and bg ~= "" then
      io.write(string.format("\027]11;%s\007", bg))
      io.flush()
    end
  end,
})
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    io.write("\027]111\007")
    io.flush()
  end,
})

local pack = require("util.pack_load")

-- Explicit list (not a glob) so load order is deterministic. UI first because
-- it provides shared deps (plenary, devicons) used by later modules.
for _, name in ipairs({
  "ui",
  "treesitter",
  "lsp",
  "git",
  "finder",
  "editing",
  "markdown",
  "colorschemes",
}) do
  require("plugins." .. name)(pack.add)
end

pack.commit()

-- configuration modules
require("config.options")
require("config.keymaps")
require("config.colorscheme")
require("config.lsp")
