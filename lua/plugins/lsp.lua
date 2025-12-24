return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {
          ui = {
            border = "rounded",
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗",
            },
          },
        },
      },
      {
        "mason-org/mason-lspconfig.nvim",
        opts = {
          ensure_installed = { "pyright", "clangd", "lua_ls" },
          automatic_enable = { exclude = { "stylua" } },
        },
      },
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },

    config = function()
      -- Global diagnostics UI
      vim.diagnostic.config({
        virtual_text = { spacing = 2, prefix = "●" },
        severity_sort = true,
        float = { border = "rounded" },
      })

      -- Keymaps: attach once, apply to any LSP buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
          end

          map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
          -- add more LSP maps here if you want
        end,
      })

      -- Server-specific configuration (Neovim 0.11+ style)
      vim.lsp.config("lua_ls", {
        -- put lua_ls settings here if/when you need them
      })

      vim.lsp.config("pyright", {})
      vim.lsp.config("clangd", {})
      -- no vim.lsp.enable() calls needed: mason-lspconfig handles it
    end,
  },
}
