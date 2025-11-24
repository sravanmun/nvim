return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration

      -- Only one of these is needed.
      "ibhagwan/fzf-lua",              -- optional
      "echasnovski/mini.pick",         -- optional
      "folke/snacks.nvim",             -- optional
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit Status" },

      -- Popups (like Magit)
      { "<leader>gc", function() require("neogit").open({ "commit" }) end,
        desc = "Commit Popup" },
      { "<leader>gp", function() require("neogit").open({ "push" }) end,
        desc = "Push Popup" },
      { "<leader>gf", function() require("neogit").open({ "pull" }) end,
        desc = "Pull Popup" },

      -- Logs
      { "<leader>gl", function() require("neogit").open({ "log" }) end,
        desc = "Log (cwd)" },

      -- Diff / DiffView integration
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff (Diffview)" },
      { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },

      -- Fast commands
      { "<leader>gs", "<cmd>Neogit kind=split<cr>", desc = "Status (split)" },
      { "<leader>gb", "<cmd>Neogit branch<cr>", desc = "Branch manager" },
    }
  },
}
