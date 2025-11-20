return {
  -- core LSP setup
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "folke/lazydev.nvim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
     config = function()

      vim.diagnostic.config({
        virtual_text = { spacing = 2, prefix = "●" }, severity_sort = true,
        float = { border = "rounded" },
      })


      local on_attach = function(_, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
        end
        -- Hover documentation (NORMAL)
        map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
      end

      -- lua (neovim language)
      vim.lsp.config('lua_ls', { on_attach = on_attach })
      vim.lsp.enable('lua_ls')

      -- python
      vim.lsp.config('pyright', { on_attach = on_attach })
      vim.lsp.enable('pyright')

      -- C/C++
      vim.lsp.config('clangd', { on_attach = on_attach })
      vim.lsp.enable('clangd')
    end
  },


  -- Install LSP servers, formatters, and linters
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    }
  },

  -- Tell LSP which server to use
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        "mason-org/mason.nvim",
        "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "pyright",   -- Python LSP
        "clangd",    -- C/C++ LSP
        "lua_ls",    -- Lua LSP (for Neovim config)
      },
      automatic_installation = true,
    },
  },

  -- make lsp work nice with neovim config
  {
     "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

}
