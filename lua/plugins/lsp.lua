-- Built-in LSP setup lives in lua/config/lsp.lua. This file is for
-- LSP-adjacent plugins.
return function(add)
  add({
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } },
    },
  })
end
