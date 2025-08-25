
return {
  -- TODO: grug-far for search and replace in multiple files
  -- TODO: Flash for showing labels
  -- TODO: trouble nvim

    -- TODO: maybe add mini.ai for around and inside
  -- { "echasnovski/mini.comment", version = false, opts = {} },
  -- { "echasnovski/mini.surround", version = false, opts = {} },

  -- underline current word
  -- { "RRethy/vim-illuminate", opts = { delay = 150 } },



  -- auto pairs
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {
      modes = { insert = true, command = true, terminal = false },
      -- skip autopair when next character is one of these
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      -- skip autopair when the cursor is inside these treesitter nodes
      skip_ts = { "string" },
      -- skip autopair when next character is closing pair
      -- and there are more closing pairs than opening pairs
      skip_unbalanced = true,
      -- better deal with markdown code blocks
      markdown = true,
    },
  },


  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      keywords = {
        -- built-ins you can keep/override
        FIX   = { icon = " ", color = "error", alt = { "FIXME", "FIXIT", "ISSUE" } },
        HACK  = { icon = " ", color = "warning" },
        TODO  = { icon = " ", color = "info" },
        WARN  = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF  = { icon = " ", color = "perf", alt = { "OPTIM", "OPTIMIZE" } },
        NOTE  = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST  = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        -- your additions / tweaks
        BUG   = { icon = " ", color = "error", alt = { "DEFECT" } }, -- also counted as an issue
        DEBUG = { icon = " ", color = "hint",  alt = { "DBG" } },
        DONE  = { icon = " ", color = "done",  alt = { "CLOSED", "RESOLVED" } },
      },
      -- optional: add custom color groups
      colors = {
        perf   = { "#A3BE8C" },
        test   = { "#B48EAD" },
        done   = { "DiffAdded", "#22C55E" },   -- green-ish for DONE
      },
      -- (defaults are fine, but you can keep this)
      search = { pattern = [[\b(KEYWORDS)\b]] },
    },
  },
  config = function(_, opts)
    local tc = require("todo-comments")
    tc.setup(opts)
    vim.api.nvim_set_hl(0, "TodoFg", { fg = "#ff0000" })

    local map = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
    end
    map("]t", function() tc.jump_next() end, "Next TODO")
    map("[t", function() tc.jump_prev() end, "Prev TODO")
  end,
}
