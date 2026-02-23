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
        virtual_text = false,
        virtual_lines = {
                    current_line = true,  --- set to false to show for all line
        },
        severity_sort = true,
        float = { border = "rounded" },
      })

      -- Toggle: stop all active clients, or restart them for the current buffer
      vim.keymap.set("n", "<leader>lt", function()
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        if #clients > 0 then
          vim.lsp.stop_client(clients, true)
          vim.notify("LSP disabled", vim.log.levels.INFO)
        else
          -- Re-detect and start servers for the current buffer
          vim.cmd("edit")
          vim.notify("LSP enabled", vim.log.levels.INFO)
        end
      end, { silent = true, desc = "Toggle LSP" })


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
      vim.lsp.config("lua_ls", {})
      vim.lsp.config("pyright", {})
      vim.lsp.config("clangd", {})
    end,
  },
}
