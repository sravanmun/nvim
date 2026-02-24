-- ~/.config/nvim/lua/plugins/fzf.lua
return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional icons
    cmd = "FzfLua",

    opts = {
        winopts = { border = "rounded" },
    },
    keys = {
        { "<leader><space>", "<cmd>FzfLua files<cr>", desc = "Find Files" },
        { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find Files" },
        { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Grep" },
        { "<leader>f/", "<cmd>FzfLua grep_curbuf<cr>", desc = "Grep Current Buffer" },
        { "<leader>fR", "<cmd>FzfLua resume<cr>", desc = "Resume Last Search" },
        { "<leader>fh", "<cmd>FzfLua help_tags<cr>", desc = "Help Tags" },
        { "<leader>fk", "<cmd>FzfLua keymaps<cr>", desc = "Keymaps" },
        { "<leader>bb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
        { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent Files" },
        { "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
        { "<leader>uc", "<cmd>FzfLua colorschemes<cr>", desc = "Toggle Colorschemes" },
        {
            "<leader>cv",
            function()
                require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
            end,
            desc = "Neovim Config"
        },
        {
            "<leader>fd",
            function()
                require("fzf-lua").files({ cwd = vim.fn.expand("%:p:h") })
            end,
            desc = "Files in Current Dir"
        },
    },
}
