-- ~/.config/nvim/lua/plugins/neogen.lua
return {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {
        languages = {
            python = {
                template = {
                    annotation_convention = "numpydoc",
                },
            },
        },
    },
    keys = {
        {
            "<leader>nf",
            function() require("neogen").generate() end,
            desc = "Generate documentation",
        },
    },
}
