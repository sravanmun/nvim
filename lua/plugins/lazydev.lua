-- ~/.config/nvim/lua/plugins/lazydev.lua
-- Native LSP setup lives in lua/config/lsp.lua.
-- Only plugin needed here is lazydev for nvim-runtime Lua type info.
return {
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
}
