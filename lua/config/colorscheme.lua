-- ~/.config/nvim/lua/colorscheme.lua
vim.opt.termguicolors = true

-- Paths to store settings
local data_path = vim.fn.stdpath("data")
local colorscheme_file = data_path .. "/current_colorscheme.txt"
local background_file = data_path .. "/current_background.txt"

-- Function to save colorscheme to file
local function save_colorscheme(colorscheme)
	local file = io.open(colorscheme_file, "w")
	if file then
		file:write(colorscheme)
		file:close()
	end
end

-- Function to save background to file
local function save_background(background)
	local file = io.open(background_file, "w")
	if file then
		file:write(background)
		file:close()
	end
end

-- Function to load saved colorscheme
local function load_saved_colorscheme()
	local file = io.open(colorscheme_file, "r")
	if file then
		local colorscheme = file:read("*a")
		file:close()
		return vim.trim(colorscheme)
	end
	return nil
end

-- Function to load saved background
local function load_saved_background()
	local file = io.open(background_file, "r")
	if file then
		local background = file:read("*a")
		file:close()
		return vim.trim(background)
	end
	return nil
end

-- Function to get macOS system theme
local function get_macos_theme()
	if vim.fn.has("mac") == 1 then
		local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
		if handle then
			local result = handle:read("*a")
			handle:close()
			if result:match("Dark") then
				return "dark"
			else
				return "light"
			end
		end
	end
	return nil
end

-- Get the settings to use
local default_colorscheme = "solarized"
local default_background = "light"

local colorscheme = load_saved_colorscheme() or default_colorscheme
local background

-- Check if macOS and use system theme, otherwise use saved/default
local macos_theme = get_macos_theme()
if macos_theme then
	-- background = macos_theme
	background = load_saved_background() or default_background
else
	background = load_saved_background() or default_background
end

-- Set background
vim.o.background = background

-- Load colorscheme safely
local ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
if not ok then
	vim.notify("Colorscheme " .. colorscheme .. " not found! Using default.")
	pcall(vim.cmd.colorscheme, default_colorscheme)
end

-- Create autocmd to save colorscheme whenever it changes
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		local current = vim.g.colors_name
		if current then
			save_colorscheme(current)
		end
	end,
})

-- Only save background changes on non-macOS systems
vim.api.nvim_create_autocmd("OptionSet", {
	pattern = "background",
	callback = function()
		-- Only save if not on macOS (since macOS follows system)
		if vim.fn.has("mac") ~= 1 then
			save_background(vim.o.background)
		end
	end,
})

--[[
-- Optional: Periodically check macOS system theme (every 5 minutes)
if vim.fn.has("mac") == 1 then
	vim.fn.timer_start(300000, function()
		local current_macos_theme = get_macos_theme()
		if current_macos_theme and current_macos_theme ~= vim.o.background then
			vim.o.background = current_macos_theme
		end
	end, { ["repeat"] = -1 })
end
]]
