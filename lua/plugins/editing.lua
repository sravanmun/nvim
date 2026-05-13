return function(add)
  add({
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("illuminate").configure({
        delay = 200,
        large_file_cutoff = 2000,
        large_file_overrides = { providers = { "lsp" } },
      })
    end,
  })

  add({
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      signs = false,
      highlight = { before = "", keyword = "fg", after = "", pattern = [[.*<(KEYWORDS)\s*]] },
      gui_style = { fg = "NOCOMBINE,bold" },
      -- (full keyword/color table elided — copy from previous config if you want
      -- the custom BUG/DEBUG/DONE/etc. keywords and colors back.)
    },
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next TODO" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev TODO" },
    },
  })

  add({
    "danymat/neogen",
    opts = {
      languages = { python = { template = { annotation_convention = "numpydoc" } } },
    },
    keys = {
      { "<leader>nf", function() require("neogen").generate() end, desc = "Gen docs" },
    },
  })
end
