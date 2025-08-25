-- ~/.config/nvim/lua/keymaps.lua
local ui = require("util.ui")


-- edit config files
vim.keymap.set('n', '<leader>ck', '<cmd>e ~/.config/kitty/kitty.conf<cr>',   { desc = 'kitty.config' })
vim.keymap.set('n', '<leader>cz', '<cmd>e ~/.config/zsh/zshrc.sh<cr>',   { desc = '.zshrc' })
vim.keymap.set('n', '<leader>cv', function()
  require("snacks").picker.files({ cwd = vim.fn.stdpath("config") })
end, { desc = 'neovim' })

-- Lazy
vim.keymap.set("n", "<leader>ll", function() require("lazy").home() end, { desc = "Lazy" })

-- quit
vim.keymap.set("n", "<leader>qq", "<cmd>q<cr>",  { desc = "quite" })


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

-- ui
vim.keymap.set("n", "<leader>un",  function() ui.toggle_option("number", true) end, { desc = "Toggle line numbers" })
vim.keymap.set("n", "<leader>uN",  function() ui.toggle_option("relativenumber", true) end,  { desc = "Toggle line numbers (all)" })

-- change background
vim.keymap.set("n", "<leader>ub", function() ui.toggle_background() end, { desc = "Toggle background (dark/light)" })
