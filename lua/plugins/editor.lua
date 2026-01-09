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
    -- TODO: coppied for chatgpt as a quick fix. Go through this carefully
    {
      "echasnovski/mini.pairs",
      event = "VeryLazy",
      opts = {
        modes = { insert = true, command = true, terminal = false },
        skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
        skip_ts = { "string" },
        skip_unbalanced = true,
        markdown = false,
      },
      config = function(_, opts)
        require("mini.pairs").setup(opts)

        local function literal_i(buf, ch)
          vim.keymap.set("i", ch, function() return ch end, {
            buffer = buf,
            expr = true,
            noremap = true,
            silent = true,
          })
        end

        local function apply(buf)
          local ft = vim.bo[buf].filetype
          if ft == "python" then
            literal_i(buf, '"')     -- disable " autopair in python only
          elseif ft == "markdown" then
            literal_i(buf, "`")     -- disable ` autopair in markdown only
          end
        end

        -- Apply when filetype is set (future buffers)
        vim.api.nvim_create_autocmd("FileType", {
          pattern = { "python", "markdown" },
          callback = function(ev) apply(ev.buf) end,
        })

        -- Apply to buffers that already existed before mini.pairs loaded
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_loaded(buf) then
            apply(buf)
          end
        end
      end,
    },
	-- zen mode
	{
		"folke/zen-mode.nvim",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			keywords = {
				-- built-ins you can keep/override
				FIX = { icon = " ", color = "error", alt = { "FIXME", "FIXIT", "ISSUE" } },
				HACK = { icon = " ", color = "warning" },
				TODO = { icon = " ", color = "info" },
				WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
				PERF = { icon = " ", color = "perf", alt = { "OPTIM", "OPTIMIZE" } },
				NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
				TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
				-- your additions / tweaks
				BUG = { icon = " ", color = "error", alt = { "DEFECT" } }, -- also counted as an issue
				DEBUG = { icon = " ", color = "hint", alt = { "DBG" } },
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
		config = function(_, opts)
			local tc = require("todo-comments")
			tc.setup(opts)
			vim.api.nvim_set_hl(0, "TodoFg", { fg = "#ff0000" })

			local map = function(lhs, rhs, desc)
				vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
			end
			map("]t", function()
				tc.jump_next()
			end, "Next TODO")
			map("[t", function()
				tc.jump_prev()
			end, "Prev TODO")
		end,
	},
}
