-- ~/.config/nvim/lua/config/lsp.lua
-- Native LSP + completion (no nvim-lspconfig, no mason)
-- Server configs live in ~/.config/nvim/lsp/<name>.lua

vim.lsp.enable({ "pyright", "clangd", "lua_ls", "vhdl_ls" })

vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = { current_line = true },
    severity_sort = true,
    float = { border = "rounded" },
})

vim.keymap.set("n", "<leader>lt", function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients > 0 then
        vim.g.lsp_enabled = false
        for _, client in ipairs(clients) do
            client:stop(true)
        end
        vim.notify("LSP disabled", vim.log.levels.INFO)
    else
        vim.g.lsp_enabled = true
        vim.cmd("edit")
        vim.notify("LSP enabled", vim.log.levels.INFO)
    end
end, { silent = true, desc = "Toggle LSP" })

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if vim.g.lsp_enabled == false then
            if client then client:stop(true) end
            return
        end

        -- Native LSP completion (autotrigger on trigger chars from server)
        if client and client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
        end

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
        map({ "i", "s" }, "<C-k>", vim.lsp.buf.signature_help, "Signature Help")
    end,
})
