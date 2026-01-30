-- lua/plugins/indent-blankline.lua
return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
        indent = {
            char = "│",
            tab_char = "│",
        },
        scope = {
            enabled = true,
            show_start = false,
            show_end = false,
        },
    },
    keys = {
        { "<leader>ti", "<cmd>IBLToggle<cr>", desc = "Toggle Indent Guides" },
    },
}
