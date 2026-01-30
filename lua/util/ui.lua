-- ~/.config/nvim/lua/user/util/ui.lua
local M = {}

function M.toggle_option(opt, all)
	local newval = not vim.wo[opt]
	if all then
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			-- vim.api.nvim_win_set_option(win, opt, newval)
			vim.api.nvim_set_option_value(opt, newval, { win = win })
		end
	else
		vim.opt_local[opt] = newval
	end
end

function M.toggle_signcolumn()
    if vim.opt.signcolumn:get() == "yes" then
        vim.opt.signcolumn = "no"
        vim.notify("Sign column hidden", vim.log.levels.INFO)
    else
        vim.opt.signcolumn = "yes"
        vim.notify("Sign column shown", vim.log.levels.INFO)
    end
end

function M.toggle_background()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end

  -- reload current colorscheme (if one is set)
  local cs = vim.g.colors_name
  if cs and cs ~= "" then
    vim.cmd.colorscheme(cs)
  end
end

return M
