return function(add)
  add({
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    opts = { winopts = { border = "rounded" } },
    keys = {
      { "<leader><space>", "<cmd>FzfLua files<cr>" },
      { "<leader>ff",      "<cmd>FzfLua files<cr>" },
      { "<leader>fg",      "<cmd>FzfLua live_grep<cr>" },
      { "<leader>f/",      "<cmd>FzfLua grep_curbuf<cr>" },
      { "<leader>fR",      "<cmd>FzfLua resume<cr>" },
      { "<leader>fh",      "<cmd>FzfLua help_tags<cr>" },
      { "<leader>fk",      "<cmd>FzfLua keymaps<cr>" },
      { "<leader>bb",      "<cmd>FzfLua buffers<cr>" },
      { "<leader>fr",      "<cmd>FzfLua oldfiles<cr>" },
      { "<leader>:",       "<cmd>FzfLua command_history<cr>" },
      { "<leader>uc",      "<cmd>FzfLua colorschemes<cr>" },
      { "<leader>cv",      function() require("fzf-lua").files({ cwd = vim.fn.stdpath("config") }) end },
      { "<leader>fd",      function() require("fzf-lua").files({ cwd = vim.fn.expand("%:p:h") }) end },
    },
  })
end
