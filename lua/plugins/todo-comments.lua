-- ~/.config/nvim/lua/plugins/todo-comments.lua
return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        signs = false,
        highlight = {
            before = "",
            keyword = "fg",
            after = "",
            pattern = [[.*<(KEYWORDS)\s*]],
        },
        gui_style = {
            fg = "NOCOMBINE,bold",
        },
        keywords = {
            -- built-ins you can keep/override
            FIX = { icon = " ", color = "error", alt = { "FIXME", "FIXIT", "ISSUE" } },  -- FIX
            HACK = { icon = " ", color = "warning" },                                    -- HACK
            TODO = { icon = " ", color = "info" },                                       -- TODO
            WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },        -- WARN
            PERF = { icon = " ", color = "perf", alt = { "OPTIM", "OPTIMIZE" } },        -- PERF
            NOTE = { icon = " ", color = "hint", alt = { "INFO" } },                     -- NOTE
            TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } }, -- TEST
            -- your additions / tweaks       
            BUG = { icon = " ", color = "error", alt = { "DEFECT" } }, -- also counted as an issue
            DEBUG = { icon = " ", color = "hint", alt = { "DEBUG" } },
            DONE = { icon = " ", color = "done", alt = { "CLOSED", "RESOLVED" } },
        },
        -- optional: add custom color groups
        colors = {
            perf = { "#A3BE8C" },
            test = { "#B48EAD" },
            done = { "DiffAdded", "#22C55E" }, -- green-ish for DONE
        },
        -- (defaults are fine, but you can keep this)
        search = { pattern = [[\b(KEYWORDS)\b]] },
    },
    keys = {
        { "]t", function() require("todo-comments").jump_next() end, desc = "Next TODO" },
        { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev TODO" },
    },
}
