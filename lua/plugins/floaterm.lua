return {
    "nvzone/floaterm",
    dependencies = "nvzone/volt",
    cmd = "FloatermToggle",
    opts = {},
    keys = {
        { "<C-t>", "<cmd>FloatermToggle<cr>", desc = "Toggle floating terminal", mode = "n" },
        { "<C-t>", [[<C-\><C-n><cmd>FloatermToggle<cr>]], desc = "Toggle floating terminal", mode = "t" },
    },
}
