-- ~/.config/nvim/lua/plugins/gitsigns.lua
return {
    {
      "akinsho/git-conflict.nvim",
      version = "*",
      config = true
    },

    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            signs = {
                add          = { text = "▎" },
                change       = { text = "▎" },
                delete       = { text = "" },
                topdelete    = { text = "" },
                changedelete = { text = "▎" },
                untracked    = { text = "▎" },
            },
        },
        keys = {
            { "]g", function() require("gitsigns").nav_hunk("next") end, desc = "Next Hunk" },
            { "[g", function() require("gitsigns").nav_hunk("prev") end, desc = "Prev Hunk" },
            { "<leader>ghs", "<cmd>Gitsigns stage_hunk<cr>",   desc = "Stage Hunk" },
            { "<leader>ghr", "<cmd>Gitsigns reset_hunk<cr>",   desc = "Reset Hunk" },
            { "<leader>ghu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "Undo Stage Hunk" },
            { "<leader>ghp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview Hunk" },
            { "<leader>ghb", "<cmd>Gitsigns blame_line<cr>",   desc = "Blame Line" },
            { "<leader>ghs", ":Gitsigns stage_hunk<cr>", mode = "v", desc = "Stage Hunk" },
            { "<leader>ghr", ":Gitsigns reset_hunk<cr>", mode = "v", desc = "Reset Hunk" },
        },
    },

}
