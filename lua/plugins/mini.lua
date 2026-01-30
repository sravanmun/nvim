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

	-- icons
	{
		"echasnovski/mini.icons",
		lazy = true,
		opts = {},
		config = function(_, opts)
			require("mini.icons").setup(opts)
		end,
	},

    -- buff delete
    {
        "echasnovski/mini.bufremove",
        keys = {
            {
                "<leader>bd",
                function() require("mini.bufremove").delete(0, false) end,
                desc = "Delete Buffer"
            },
        },
    }
}
