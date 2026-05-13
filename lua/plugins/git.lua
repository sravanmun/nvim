return function(add)
  add({
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" }, change = { text = "▎" },
        delete = { text = "" }, topdelete = { text = "" },
        changedelete = { text = "▎" }, untracked = { text = "▎" },
      },
    },
  })

  add({
    "akinsho/git-conflict.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function() require("git-conflict").setup() end,
  })

  add({ "sindrets/diffview.nvim", cmd = { "DiffviewOpen", "DiffviewClose" } })

  add({
    "NeogitOrg/neogit",
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>",            desc = "Status" },
      { "<leader>gc", "<cmd>Neogit commit<cr>",     desc = "Commit" },
      { "<leader>gp", "<cmd>Neogit pull<cr>",       desc = "Pull" },
      { "<leader>gP", "<cmd>Neogit push<cr>",       desc = "Push" },
      { "<leader>gl", "<cmd>Neogit log<cr>",        desc = "Log" },
      { "<leader>gb", "<cmd>Neogit branch<cr>",     desc = "Branch" },
      { "<leader>gd", "<cmd>DiffviewOpen<cr>",      desc = "Diff" },
      { "<leader>gD", "<cmd>DiffviewClose<cr>",     desc = "Close diff" },
      { "<leader>gs", "<cmd>Neogit kind=split<cr>", desc = "Split status" },
    },
  })
end
