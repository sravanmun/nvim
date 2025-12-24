-- ~/.config/nvim/init.lua

-- leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- bootstrap lazy.vim extention manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv or vim.loop
if not uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins from lua/plugins/*
require("lazy").setup({
	spec = { { import = "plugins" } },
	change_detection = { enabled = false },
})

-- configuration
require("config.options")
require("config.keymaps")
