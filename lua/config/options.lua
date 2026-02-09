-- ~/.config/nvim/lua/options.lua
-- indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.expandtab = true

-- columns
-- Add to your init.lua or options.lua
vim.opt.number = true
-- vim.opt.relativenumber = true
-- vim.opt.foldcolumn = "1"    -- Optional: show fold column
-- vim.opt.statuscolumn = [[%s%=%{v:relnum?v:relnum:v:lnum} ]]

vim.opt.clipboard = "unnamedplus" -- use the + register (system)

-- change split direction
vim.opt.splitright = true
vim.opt.splitbelow = true

-- use Treesitter folds
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- optional: start with folds open
vim.opt.foldlevel = 99
vim.opt.foldenable = true

-- Make CursorHold fire quickly
vim.o.updatetime = 500 -- 0.5s idle

-- Always show sign column (helps confirm diagnostics exist)
vim.o.signcolumn = "no"

-- file highlighting
vim.filetype.add({
	extension = {
		seq = "yaml",
		bcf = "toml",
	},
})

if vim.fn.getenv("TERM_PROGRAM") == "ghostty" then
  vim.opt.title = true
  vim.opt.titlestring = "%{fnamemodify(getcwd(), ':t')}"
end
