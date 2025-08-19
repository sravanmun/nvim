-- ~/.config/nvim/lua/plugins/ui.lua
function toggle_indent()
  -- try snacks.indent module first
  local ok_ind, ind = pcall(require, "snacks.indent")
  if ok_ind and ind then
    if type(ind.toggle) == "function" then
      ind.toggle()
      return
    end
    -- fallback: enable/disable pair
    local get_enabled = ind.enabled
    local enabled = type(get_enabled) == "function" and get_enabled() or get_enabled
    if enabled == nil then
      -- assume enabled if no flag; try disable->enable sequence
      if type(ind.disable) == "function" then ind.disable(); return end
    else
      if enabled and type(ind.disable) == "function" then ind.disable(); return end
      if (not enabled) and type(ind.enable) == "function" then ind.enable(); return end
    end
  end

  -- try generic toggle module
  local ok_tog, st = pcall(require, "snacks.toggle")
  if ok_tog and st then
    if type(st.toggle) == "function" then st.toggle("indent"); return end
    if type(st.menu) == "function" then st.menu(); return end
  end

  vim.notify(
    "Could not toggle Snacks indent. Update snacks.nvim, ensure main='snacks' and indent.enabled=true.",
    vim.log.levels.WARN
  )
end

return {
  -- color schemes
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "ellisonleao/gruvbox.nvim", lazy = true },
  { "catppuccin/nvim", name = "catppuccin", lazy = true },
  { "shaunsingh/nord.nvim", lazy = true },
  { "rebelot/kanagawa.nvim", lazy = true},
  { "Th3Whit3Wolf/space-nvim", lazy = true},
  { "sainnhe/everforest", lazy = true},
  {'maxmx03/solarized.nvim', lazy = false},

  -- icons
  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {},
    config = function(_, opts)
      require("mini.icons").setup(opts)
    end,
  },

  -- statusline (TODO make this look nicer)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "auto",
        component_separators = "",
        section_separators   = "",
        globalstatus = true,
      },
    },
    config = function(_, opts)
        require("lualine").setup(opts)
        vim.opt.laststatus = 3       -- ensure global statusline
    end,
  },

  -- bufferline (TODO do I really need this???)
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        always_show_bufferline = false,
        diagnostics = "nvim_lsp",
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      vim.opt.showtabline = 1 -- show tabline only when needed
    end,
  },

  -- Noice (experimental)
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      -- LSP UI routing & niceties
      lsp = {
        progress = { enabled = true },
        hover = { enabled = true },
        signature = { enabled = true },
        -- Improve markdown rendering in hover/signature
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },

      -- Cmdline & messages
      cmdline = { enabled = true, view = "cmdline_popup" },
      messages = { enabled = true },
      popupmenu = { enabled = true }, -- for cmdline completion popup

      -- Useful presets
      presets = {
        command_palette = true,       -- nicer cmdline layout
        long_message_to_split = true, -- long messages to a split
        inc_rename = true,            -- supports :IncRename
        lsp_doc_border = true,        -- border around hover/signature
        -- bottom_search = false,     -- set true if you prefer bottom search UI
      },

      -- Tweak the popup look/position if you like
      views = {
        cmdline_popup = {
          position = { row = "30%", col = "50%" },
          size = { width = 60, height = "auto" },
          border = { style = "single" },
        },
      },

      -- Filter out noisy messages (examples)
      routes = {
        -- exclude common save messages so they don't duplicate
        { filter = { event = "msg_show", find = "%-?%d+L,? %d*B?%s*written" }, opts = { skip = true } },
        { filter = { event = "msg_show", find = "written$" },                 opts = { skip = true } },
        { filter = { event = "msg_show", find = '^"[^"]+" %d+L, %d+B$' },     opts = { skip = true } },

        -- keep your catch-all (last so skips win first)
        { filter = { event = "msg_show" }, view = "notify" },
      },
    },
    -- Optional convenience keymaps
    keys = {
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Noice Redirect" },
      { "<leader>un", function() require("snacks.notifier").hide() end, desc = "Dismiss Notifications" },
      { "<leader>um", function() require("noice").cmd("messages") end, desc = "Noice Messages" },
      { "<leader>ul", function() require("noice").cmd("last") end,     desc = "Last Message" },
      { "<leader>uh", function() require("noice").cmd("history") end,  desc = "Message History" },
    },
  },
 

  -- snacks for quality of life improvments
  {
    "folke/snacks.nvim",
    lazy = false, -- load on startup (you can defer if you want)
    priority = 1000, -- load before colorschemes if you use its UI tweaks
    opts = {
      indent   = { enabled = true },   -- indent guides
      notifier = { enabled = true },   -- notifications
      input    = { enabled = true },   -- nicer vim.ui.input
      select   = { enabled = true },   -- nicer vim.ui.select
      scroll   = { enabled = true },   -- smooth scrolling
      scope    = { enabled = true },   -- scope highlight
      toggle   = { map = true },       -- auto-create <leader>ut toggles
      words    = { enabled = true },   -- word highlight under cursor
      image    = { enabled = true },    -- enable images [only works in kitty]
      zen      = { enabled = true },    -- zen-mode
      dashboard = {
        preset = "default",            -- startup screen
      },
    },
    keys = {
      { "<leader>ui", toggle_indent, desc = "Toggle Indent Guides" },
      { "<leader>un", function() require("snacks.notifier").hide() end, desc = "Dismiss All Notifications" },
      { "<leader>n", function()
          if Snacks.config.picker and Snacks.config.picker.enabled then
            Snacks.picker.notifications()
          else
            Snacks.notifier.show_history()
          end
        end,
        desc = "Notification History"
      },
    },
  }

}
