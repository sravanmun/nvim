-- ~/.config/nvim/lua/plugins/nvim-tree.lua
return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer (Tree)" },
    },
    opts = {},
}
