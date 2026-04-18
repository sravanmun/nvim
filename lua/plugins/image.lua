-- ~/.config/nvim/lua/plugins/image.lua
return {
    {
        "3rd/image.nvim",
        cond = function() return vim.fn.has("mac") == 1 end,
        build = "luarocks --local --lua-version=5.1 install magick",
        opts = {},
    },
}
