return {
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"ibhagwan/fzf-lua",
			"echasnovski/mini.pick",
			"folke/snacks.nvim",
		},
		cmd = "Neogit",

        keys = {
          { "<leader>g", group = "git" },

          { "<leader>gg", "<cmd>Neogit<cr>",         desc = "Neogit Status" },
          { "<leader>gc", "<cmd>Neogit commit<cr>",  desc = "Commit Popup" },
          { "<leader>gp", "<cmd>Neogit pull<cr>",    desc = "Pull Popup" },
          { "<leader>gP", "<cmd>Neogit push<cr>",    desc = "Push Popup" },
          { "<leader>gl", "<cmd>Neogit log<cr>",     desc = "Log (cwd)" },
          { "<leader>gb", "<cmd>Neogit branch<cr>",  desc = "Branch manager" },

          { "<leader>gd", "<cmd>DiffviewOpen<cr>",   desc = "Diff (Diffview)" },
          { "<leader>gD", "<cmd>DiffviewClose<cr>",  desc = "Close Diffview" },

          { "<leader>gs", "<cmd>Neogit kind=split<cr>", desc = "Status (split)" },
        },
}
