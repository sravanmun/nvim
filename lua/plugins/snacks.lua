local function toggle_indent()
	-- try snacks.indent module first
	local ok_ind, ind = pcall(require, "snacks.indent")
	if ok_ind and ind then
		if type(ind.toggle) == "function" then
			ind.toggle()
			return
		end
		-- fallback: enable/disable pair
		local get_enabled = ind.enabled
		local enabled = type(get_enabled) == "function" and get_enabled() or get_enabled
		if enabled == nil then
			-- assume enabled if no flag; try disable->enable sequence
			if type(ind.disable) == "function" then
				ind.disable()
				return
			end
		else
			if enabled and type(ind.disable) == "function" then
				ind.disable()
				return
			end
			if (not enabled) and type(ind.enable) == "function" then
				ind.enable()
				return
			end
		end
	end

	-- try generic toggle module
	local ok_tog, st = pcall(require, "snacks.toggle")
	if ok_tog and st then
		if type(st.toggle) == "function" then
			st.toggle("indent")
			return
		end
		if type(st.menu) == "function" then
			st.menu()
			return
		end
	end

	vim.notify(
		"Could not toggle Snacks indent. Update snacks.nvim, ensure main='snacks' and indent.enabled=true.",
		vim.log.levels.WARN
	)
end

return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		dependencies = {
			{ "ibhagwan/fzf-lua", opts = { winopts = { border = "rounded" } } },
			"nvim-tree/nvim-web-devicons", -- optional
		},
		opts = {
			-- enable the modules you want
			bufdelete = { enabled = true },
			explorer = { enabled = true },
			indent = { enabled = false },
			input = { enabled = true },
			notifier = { enabled = true },
			picker = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = true },
			terminal = { enabled = false },
			toggle = { enabled = true },
			image = { enabled = true },
			words = { enabled = true },

			-- https://patorjk.com/software/taag/
			dashboard = {
				preset = {
					header = [[
 ▄               ▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄       ▄▄ 
▐░▌             ▐░▌▐░░░░░░░░░░░▌▐░░▌     ▐░░▌
 ▐░▌           ▐░▌  ▀▀▀▀█░█▀▀▀▀ ▐░▌░▌   ▐░▐░▌
  ▐░▌         ▐░▌       ▐░▌     ▐░▌▐░▌ ▐░▌▐░▌
   ▐░▌       ▐░▌        ▐░▌     ▐░▌ ▐░▐░▌ ▐░▌
    ▐░▌     ▐░▌         ▐░▌     ▐░▌  ▐░▌  ▐░▌
     ▐░▌   ▐░▌          ▐░▌     ▐░▌   ▀   ▐░▌
      ▐░▌ ▐░▌           ▐░▌     ▐░▌       ▐░▌
       ▐░▐░▌        ▄▄▄▄█░█▄▄▄▄ ▐░▌       ▐░▌
        ▐░▌        ▐░░░░░░░░░░░▌▐░▌       ▐░▌
         ▀          ▀▀▀▀▀▀▀▀▀▀▀  ▀         ▀ 
]],
					keys = {
						{
							icon = " ",
							key = "f",
							desc = "Find File",
							action = ":lua require('snacks').picker.files() ",
						},
						{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
						{
							icon = " ",
							key = "g",
							desc = "Find Text",
							action = ":lua require('snacks').picker.grep() ",
						},
						{
							icon = " ",
							key = "r",
							desc = "Recent Files",
							action = ":lua require('snacks').picker.recent()",
						},
						{
							icon = " ",
							key = "c",
							desc = "Config",
							action = (":lua require('snacks').picker.files({ cwd = '%s' }) "):format(
								vim.fn.stdpath("config")
							),
						},
						{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
						{ icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
						{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
					},
				},
			},
		},
		keys = {
			-- top pickers
			{
				"<leader><space>",
				function()
					require("snacks").picker.smart()
				end,
				desc = "Smart Find Files",
			},
			{
				"<leader>bd",
				function()
					require("snacks").bufdelete()
				end,
				desc = "Find Files",
			},
			{
				"<leader>ff",
				function()
					require("snacks").picker.files()
				end,
				desc = "Find Files",
			},
			{
				"<leader>fg",
				function()
					require("snacks").picker.grep()
				end,
				desc = "Grep",
			},
			{
				"<leader>bb",
				function()
					require("snacks").picker.buffers()
				end,
				desc = "Buffers",
			},
			{
				"<leader>fr",
				function()
					require("snacks").picker.recent()
				end,
				desc = "Recent Files",
			},
			{
				"<leader>:",
				function()
					require("snacks").picker.command_history()
				end,
				desc = "Command History",
			},
			{
				"<leader>n",
				function()
					require("snacks").picker.notifications()
				end,
				desc = "Notification History",
			},

			-- explorer
			{
				"<leader>e",
				function()
					require("snacks").explorer()
				end,
				desc = "Explorer",
			},

			-- notifications
			-- { "<leader>un",      function() require("snacks").notifier.hide() end, desc = "Dismiss Notifications" },

			-- ui
			{ "<leader>ui", toggle_indent, desc = "Toggle Indent Guides" },
			{
				"<leader>uc",
				function()
					require("snacks").picker.colorschemes()
				end,
				desc = "Change color scheme",
			},
		},

		config = function(_, opts)
			require("snacks").setup(opts)
			-- simple LazyVim-like safe keymap helper (optional)
			_G.SafeMap = function(mode, lhs, rhs, desc)
				pcall(vim.keymap.set, mode, lhs, rhs, { desc = desc, silent = true, noremap = true })
			end
		end,
	},
}
