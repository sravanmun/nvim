-- ~/.config/nvim/lua/plugins/ui.lua
-- Also see Also see snacks.lua
return {
	-- icons
	{
		"echasnovski/mini.icons",
		lazy = true,
		opts = {},
		config = function(_, opts)
			require("mini.icons").setup(opts)
		end,
	},

	-- floating terminal
	{ "akinsho/toggleterm.nvim", version = "*", config = true },

	-- statusline (TODO make this look nicer)
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "auto",
				component_separators = "",
				section_separators = "",
				globalstatus = true,
			},
		},
		config = function(_, opts)
			require("lualine").setup(opts)
			vim.opt.laststatus = 3 -- ensure global statusline
		end,
	},

	-- bufferline (TODO do I really need this???)
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
			{ "<leader>bn", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
			{ "<leader>bp", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" },
		},
		config = function(_, opts)
			require("bufferline").setup(opts)
			vim.opt.showtabline = 1 -- show tabline only when needed
		end,
	},

	-- fzf_lua for fuzzy finding backend
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional icons
		cmd = "FzfLua",
		-- you can tune defaults here; Snacks will just call into fzf-lua
		opts = {
			winopts = { border = "rounded" },
		},
		config = function(_, opts)
			require("fzf-lua").setup(opts)
		end,
	},
}
