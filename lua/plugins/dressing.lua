return {
    "stevearc/dressing.nvim",
    opts = {
        input = {
            enabled = true,
            default_prompt = "Input:",
            border = "rounded",
        },
        select = {
            enabled = true,
            backend = { "fzf_lua", "builtin" },  -- Uses fzf-lua first!
            fzf_lua = {
                winopts = {
                    height = 0.5,
                    width = 0.5,
                },
            },
        },
    },
}
