return function(add)
  add({
    "nvim-treesitter/nvim-treesitter",
    version = "main",
    config = function()
      require("nvim-treesitter").install({
        "bash", "c", "cpp", "cmake", "lua", "vim", "vimdoc", "regex",
        "python", "markdown", "markdown_inline", "json", "yaml", "toml",
        "html", "css", "javascript", "query", "gitcommit", "gitignore", "vhdl",
      })
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args) pcall(vim.treesitter.start, args.buf) end,
      })
    end,
  })

  add({
    "nvim-treesitter/nvim-treesitter-textobjects",
    version = "main",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      vim.g.no_plugin_maps = true
      require("nvim-treesitter-textobjects").setup({ select = { lookahead = true } })

      local sel = function(obj)
        return function()
          require("nvim-treesitter-textobjects.select").select_textobject(obj, "textobjects")
        end
      end
      for lhs, obj in pairs({
        af = "@function.outer", ["if"] = "@function.inner",
        ac = "@class.outer",    ic = "@class.inner",
        ab = "@block.outer",    ib = "@block.inner",
      }) do
        vim.keymap.set({ "x", "o" }, lhs, sel(obj), { desc = obj })
      end

      local mv = function(dir, obj)
        return function()
          require("nvim-treesitter-textobjects.move")["goto_" .. dir .. "_start"](obj, "textobjects")
        end
      end
      vim.keymap.set({ "n", "x", "o" }, "]m", mv("next", "@function.outer"))
      vim.keymap.set({ "n", "x", "o" }, "]c", mv("next", "@class.outer"))
      vim.keymap.set({ "n", "x", "o" }, "[m", mv("previous", "@function.outer"))
      vim.keymap.set({ "n", "x", "o" }, "[c", mv("previous", "@class.outer"))
    end,
  })

  add({
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    opts = { mode = "cursor", max_lines = 3 },
    module = "treesitter-context",
  })
end
