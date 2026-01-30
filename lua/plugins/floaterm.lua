return {
    "nvzone/floaterm",
    dependencies = "nvzone/volt",
    cmd = "FloatermToggle",
    opts = {},
    keys = {
        { "<leader>tt", "<cmd>FloatermToggle<cr>", desc = "Open Floating Terminal", mode = "n" },
        { "<C-t>", "<cmd>FloatermToggle<cr>", desc = "Toggle floating terminal", mode = "n" },
        { "<C-t>", [[<C-\><C-n><cmd>FloatermToggle<cr>]], desc = "Toggle floating terminal", mode = "t" },
    },
}
