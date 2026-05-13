return function(add)
  add({ "nvim-tree/nvim-web-devicons" })
  add({ "nvim-lua/plenary.nvim" })

  add({
    "nvim-lualine/lualine.nvim",
    config = function()
      vim.opt.laststatus = 2
      require("lualine").setup({
        options = {
          theme = "auto",
          component_separators = "",
          section_separators = "",
          globalstatus = false,
        },
      })
    end,
  })

  add({
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup({
        preset = "helix",
        spec = {
          {
            mode = { "n", "v" },
            { "<leader>b", group = "buffer" },
            { "<leader>c", group = "config" },
            { "<leader>e", group = "explorer" },
            { "<leader>f", group = "file/find" },
            { "<leader>g", group = "git" },
            { "<leader>l", group = "lsp" },
            { "<leader>m", group = "mode" },
            { "<leader>n", group = "docs" },
            { "<leader>q", group = "quit/session" },
            { "<leader>t", group = "tab" },
            { "<leader>u", group = "ui" },
            { "<leader>x", group = "diagnostics/quickfix" },
            { "[", group = "prev" },
            { "]", group = "next" },
            { "z", group = "fold" },
          },
        },
      })
    end,
    keys = {
      { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer keys" },
    },
  })

  add({
    "nvim-tree/nvim-tree.lua",
    opts = {},
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer" },
    },
  })

  add({
    "folke/zen-mode.nvim",
    opts = {},
    keys = { { "<leader>uz", "<cmd>ZenMode<cr>", desc = "Zen" } },
  })
end
