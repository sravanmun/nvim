return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        options = {
            theme = "auto",
            component_separators = "",
            section_separators = "",
            globalstatus = true,
        },
    },
    config = function(_, opts)
        require("lualine").setup(opts)
        vim.opt.laststatus = 3 -- ensure global statusline
    end,
}
