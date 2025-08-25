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

function M.toggle_background()
  if vim.opt.background._value == "dark" then
    vim.opt.background = "light"
  else
    vim.opt.background = "dark"
  end
  vim.cmd("colorscheme " .. vim.g.colors_name)
end


return M
