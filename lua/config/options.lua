-- ~/.config/nvim/lua/options.lua

-- indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.expandtab = true

vim.opt.clipboard = "unnamedplus"   -- use the + register (system)

-- color scheme
vim.opt.termguicolors = true
vim.o.background = "dark" -- or "light" for light mode
local default_colorscheme = "gruvbox"
-- local default_colorscheme = "zenburn"
-- local default_colorscheme = "retrobox"
-- local default_colorscheme = "everforest"

-- load color scheme safely
local ok, _ = pcall(vim.cmd.colorscheme, default_colorscheme)
if not ok then
  vim.notify("Colorscheme " .. default_colorscheme .. " not found!")
end

-- change split direction
vim.opt.splitright = true
vim.opt.splitbelow = true

-- use Treesitter folds
vim.opt.foldmethod = "expr"
vim.opt.foldexpr   = "nvim_treesitter#foldexpr()"

-- optional: start with folds open
vim.opt.foldlevel = 99
vim.opt.foldenable = true

-- Make CursorHold fire quickly
vim.o.updatetime = 500        -- 0.5s idle

-- Always show sign column (helps confirm diagnostics exist)
vim.o.signcolumn = "yes"


