-- bufferline
return {}

--[[ 
    {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        options = {
            always_show_bufferline = false,
            diagnostics = "nvim_lsp",
        },
    },
    -- inside your lazy.nvim plugin spec
    keys = {
        { "<leader>bl", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
        { "<leader>bh", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" },
        { "<leader>bL", "<cmd>BufferLineMoveNext<cr>",  desc = "Mover buffer right" },
        { "<leader>bH", "<cmd>BufferLineMovePrev<cr>",  desc = "Move buffer left" },
        { "<leader>bp", "<cmd>BufferLinePick<cr>",  desc = "Move buffer left" },
    },
    config = function(_, opts)
        require("bufferline").setup(opts)
        vim.opt.showtabline = 1 -- show tabline only when needed
    end,
}
--]]
