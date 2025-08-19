-- ~/.config/nvim/lua/user/keymaps.lua

-- Remap for dealing with word wrap
-- vim.keymap.set('n', 'k', 'v:count == 0 ? 'gk' : 'k'', { expr = true, silent = true })
-- vim.keymap.set('n', 'j', 'v:count == 0 ? 'gj' : 'j'', { expr = true, silent = true })


-- Buffer commands
vim.keymap.set('n', '<leader>bn', '<cmd>bnext<cr>',     { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bp', '<cmd>bprevious<cr>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>bb', '<cmd>FzfLua buffers<cr>', { desc = 'Switch buffer (FzfLua)' })
vim.keymap.set('n', '<leader>bl', '<cmd>b#<cr>',        { desc = 'Switch to last buffer' }) -- `b#` is the "alternate file"
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<cr>',   { desc = 'Delete current buffer' })
vim.keymap.set('n', '<leader>bw', '<cmd>edit<cr>',      { desc = 'Reload current buffer from disk' })


-- edit files
vim.keymap.set('n', "<leader>ff", "<cmd>FzfLua files<cr>",   {desc = "Find files" })
vim.keymap.set('n', "<leader>fb", "<cmd>FzfLua buffers<cr>", {desc = "Buffers" })
vim.keymap.set('n', "<leader>fg", "<cmd>FzfLua live_grep<cr>", {desc = "Live grep" })

-- edit rc files files
vim.keymap.set('n', '<leader>frz', '<cmd>e ~/.config/zsh/zshrc.sh<cr>',   { desc = 'edit zshrc' })
vim.keymap.set('n', '<leader>frv', '<cmd>e ~/.config/nvim/init.lua<cr>',   { desc = 'edit zshrc' })


-- quit
vim.keymap.set("n", "<leader>qq", "<cmd>q<cr>",  { desc = "quite" })

-- Toggle line numbers in current buffer
vim.keymap.set("n", "<leader>tu", function()
  vim.wo.number = not vim.wo.number
end, { desc = "Toggle line numbers" })

-- Toggle line numbers in *all* windows/buffers
vim.keymap.set("n", "<leader>tN", function()
  local newval = not vim.wo.number
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    vim.wo[win].number = newval
  end
end, { desc = "Toggle line numbers (all buffers)" })


-- Move to window using hjkl>
vim.keymap.set('n', '<leader>wh', '<C-w>h', { desc = 'Switch to left window' })
vim.keymap.set('n', '<leader>wj', '<C-w>j', { desc = 'Switch to lower window' })
vim.keymap.set('n', '<leader>wk', '<C-w>k', { desc = 'Switch to upper window' })
vim.keymap.set('n', '<leader>wl', '<C-w>l', { desc = 'Switch to right window' })
-- Swap windows around
vim.keymap.set("n", "<leader>wH", "<C-w>H", { desc = "Move window to far left" })
vim.keymap.set("n", "<leader>wJ", "<C-w>J", { desc = "Move window to very bottom" })
vim.keymap.set("n", "<leader>wK", "<C-w>K", { desc = "Move window to very top" })
vim.keymap.set("n", "<leader>wL", "<C-w>L", { desc = "Move window to far right" })
-- Resize splits
vim.keymap.set("n", "<leader>w<", "<C-w><", { desc = "Decrease width" })
vim.keymap.set("n", "<leader>w>", "<C-w>>", { desc = "Increase width" })
vim.keymap.set("n", "<leader>w+", "<C-w>+", { desc = "Increase height" })
vim.keymap.set("n", "<leader>w-", "<C-w>-", { desc = "Decrease height" })
-- Rotate splits
vim.keymap.set("n", "<leader>w=", "<C-w>=", { desc = "Equalize window sizes" })
vim.keymap.set("n", "<leader>wr", "<C-w>r", { desc = "Rotate windows down/right" })
vim.keymap.set("n", "<leader>wR", "<C-w>R", { desc = "Rotate windows up/left" })
-- split windows
vim.keymap.set("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "Vertical split" })
vim.keymap.set("n", "<leader>ws", "<cmd>split<cr>",  { desc = "Horizontal split" })
-- quite/close windows
vim.keymap.set("n", "<leader>wq", "<cmd>q<cr>",  { desc = "close window" })
vim.keymap.set("n", "<leader>wo", "<C-w>o", { desc = "Keep only current window" })

-- buffer navigation
-- vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
-- vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" }

-- change color scheme
vim.keymap.set("n", "<leader>uc", function()
  require("fzf-lua").colorschemes()
end, { desc = "Change color scheme" })

-- change background
vim.keymap.set("n", "<leader>ub", function()
  if vim.opt.background:get() == "dark" then
    vim.opt.background = "light"
  else
    vim.opt.background = "dark"
  end
  vim.cmd("colorscheme " .. vim.g.colors_name)
end, { desc = "Toggle background (dark/light)" })

-- open file
-- Quickfix list
vim.keymap.set('n', '[q', vim.cmd.cprev, { desc = 'Previous quickfix item' })
vim.keymap.set('n', ']q', vim.cmd.cnext, { desc = 'Next quickfix item' })

-- Diagnostics
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to prev diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist, { desc = 'Open diagnostic quickfix list' })
