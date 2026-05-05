-- ~/.config/nvim/lua/plugins/treesitter.lua
return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local parsers = {
                "bash",
                "c",
                "cpp",
                "cmake",
                "lua",
                "vim",
                "vimdoc",
                "regex",
                "python",
                "markdown",
                "markdown_inline",
                "json",
                "yaml",
                "toml",
                "html",
                "css",
                "javascript",
                "query",
                "gitcommit",
                "gitignore",
                "vhdl",
            }
            require("nvim-treesitter").install(parsers)

            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    pcall(vim.treesitter.start, args.buf)
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        event = { "BufReadPost", "BufNewFile" },
        init = function()
            vim.g.no_plugin_maps = true
        end,
        config = function()
            require("nvim-treesitter-textobjects").setup({
                select = { lookahead = true },
            })

            local select = function(obj)
                return function()
                    require("nvim-treesitter-textobjects.select").select_textobject(obj, "textobjects")
                end
            end
            vim.keymap.set({ "x", "o" }, "af", select("@function.outer"), { desc = "around function" })
            vim.keymap.set({ "x", "o" }, "if", select("@function.inner"), { desc = "inside function" })
            vim.keymap.set({ "x", "o" }, "ac", select("@class.outer"), { desc = "around class" })
            vim.keymap.set({ "x", "o" }, "ic", select("@class.inner"), { desc = "inside class" })
            vim.keymap.set({ "x", "o" }, "ab", select("@block.outer"), { desc = "around block" })
            vim.keymap.set({ "x", "o" }, "ib", select("@block.inner"), { desc = "inside block" })

            local move_next = function(obj)
                return function()
                    require("nvim-treesitter-textobjects.move").goto_next_start(obj, "textobjects")
                end
            end
            local move_prev = function(obj)
                return function()
                    require("nvim-treesitter-textobjects.move").goto_previous_start(obj, "textobjects")
                end
            end
            vim.keymap.set({ "n", "x", "o" }, "]m", move_next("@function.outer"), { desc = "next function" })
            vim.keymap.set({ "n", "x", "o" }, "]c", move_next("@class.outer"), { desc = "next class" })
            vim.keymap.set({ "n", "x", "o" }, "[m", move_prev("@function.outer"), { desc = "prev function" })
            vim.keymap.set({ "n", "x", "o" }, "[c", move_prev("@class.outer"), { desc = "prev class" })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = { "BufReadPost", "BufNewFile" },
        opts = { mode = "cursor", max_lines = 3 },
    },
}
