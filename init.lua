-- ~/.config/nvim/init.lua

-- leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- Change terminal background to match Neovim colorscheme
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    local bg = vim.fn.synIDattr(vim.fn.hlID("Normal"), "bg")
    if bg and bg ~= "" then
      io.write(string.format("\027]11;%s\007", bg))
      io.flush()
    end
  end,
})

-- Restore terminal background on exit
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    io.write("\027]111\007")
    io.flush()
  end,
})

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
require("config.colorscheme")


