-- ~/.config/nvim/lua/plugins/markdown.lua
return {
    -- markdown table
    {
        "Kicamon/markdown-table-mode.nvim",
        opts = {},
    },

    -- asciidoc
    {
        "habamax/vim-asciidoctor",
        ft = { "asciidoc", "adoc" },
    },

    -- org
    {
        "nvim-orgmode/orgmode",
        ft = { "org" },
        config = function()
            require("orgmode").setup({
                mappings = { disable_all = true },
            })
        end,
    },

    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        ft = "markdown",
        opts = {
            enabled = false,
            code = {
                sign = false,
                width = "block",
                right_pad = 1,
            },
            heading = {
                sign = false,
                icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
            },
        },
        keys = {
            {
                "<leader>um",
                function()
                    require("render-markdown").toggle()
                end,
                desc = "Toggle Render Markdown",
            },
        },
    },
}
