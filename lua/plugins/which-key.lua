-- ~/.config/nvim/lua/plugins/which-key.lua
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts_extend = { "spec" },
	opts = {
		preset = "helix",
		spec = {
			{
				mode = { "n", "v" },

				{
					"<leader>b",
					group = "buffer",
					expand = function()
						return require("which-key.extras").expand.buf()
					end,
				},
				{ "<leader>c", group = "config" },
				{ "<leader>e", group = "explorer" },
				{ "<leader>f", group = "file/find" },
				{ "<leader>g", group = "git" },
				{ "<leader>l", group = "lsp" },
				{ "<leader><S-l>", "<cmd>Lazy<cr>", desc = "Lazy" },
				{ "<leader>m", group = "mode" },
				{ "<leader>n", group = "docs" },
				{ "<leader>q", group = "quit/session" },
				{ "<leader>t", group = "tab" },
				{ "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
				{
					"<leader>w",
					group = "window",
					proxy = "<c-w>",
					expand = function()
						return require("which-key.extras").expand.win()
					end,
				},
				{ "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
				{ "[", group = "prev" },
				{ "]", group = "next" },
				{ "z", group = "fold" },
				-- better descriptions
				{ "gx", desc = "Open with system app" },
			},
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Keymaps (which-key)",
		},
		{
			"<c-w><space>",
			function()
				require("which-key").show({ keys = "<c-w>", loop = true })
			end,
			desc = "Window Hydra Mode (which-key)",
		},
	},
}
