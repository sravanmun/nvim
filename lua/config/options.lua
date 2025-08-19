-- ~/.config/nvim/lua/user/options.lua
vim.opt.tabstop = 2
vim.opt.shiftwidth = 0
vim.opt.expandtab = true


vim.opt.termguicolors = true
vim.o.background = "dark" -- or "light" for light mode


vim.opt.clipboard = "unnamedplus"   -- use the + register (system)


-- Safe load (won't error if missing)
local default_colorscheme = "retrobox"
local ok, _ = pcall(vim.cmd.colorscheme, default_colorscheme)
if not ok then
  vim.notify("Colorscheme " .. default_colorscheme .. " not found!")
end

-- change split direction
vim.opt.splitright = false  -- vsplit opens to the left
vim.opt.splitbelow = false  -- hsplit opens above

