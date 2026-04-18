-- ~/.config/nvim/lua/plugins/lsp.lua
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
            -- toggle with <leader>lt
            -- vim.g.lsp_enabled = false

            vim.lsp.enable({ "pyright", "clangd", "lua_ls", "vhdl_ls" })

            -- Global diagnostics UI
            vim.diagnostic.config({
                virtual_text = false,
                virtual_lines = {
                    current_line = true,
                },
                severity_sort = true,
                float = { border = "rounded" },
            })

            -- Toggle: stop all active clients, or restart them for the current buffer
            vim.keymap.set("n", "<leader>lt", function()
                local clients = vim.lsp.get_clients({ bufnr = 0 })
                if #clients > 0 then
                    vim.g.lsp_enabled = false
                    vim.lsp.stop_client(clients, true)
                    vim.notify("LSP disabled", vim.log.levels.INFO)
                else
                    vim.g.lsp_enabled = true
                    vim.cmd("edit")
                    vim.notify("LSP enabled", vim.log.levels.INFO)
                end
            end, { silent = true, desc = "Toggle LSP" })

            -- Keymaps: attach once, apply to any LSP buffer
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    if vim.g.lsp_enabled == false then
                        vim.lsp.stop_client(args.data.client_id, true)
                        return
                    end
                    local bufnr = args.buf
                    local map = function(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
                    end

                    map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
                    map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
                    map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
                    map("n", "gr", vim.lsp.buf.references, "References")
                    map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
                    map("n", "<leader>lr", vim.lsp.buf.rename, "Rename Symbol")
                    map("n", "<leader>la", vim.lsp.buf.code_action, "Code Action")
                    map("n", "<leader>ld", vim.diagnostic.open_float, "Line Diagnostics")
                end,
            })
        end,
    },
}
