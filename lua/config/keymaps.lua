-- ~/.config/nvim/lua/config/keymaps.lua

local function toggle_option(opt, all)
	local newval = not vim.wo[opt]
	if all then
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			vim.api.nvim_set_option_value(opt, newval, { win = win })
		end
	else
		vim.opt_local[opt] = newval
	end
end

local function toggle_signcolumn()
	if vim.opt.signcolumn:get() == "yes" then
		vim.opt.signcolumn = "no"
		vim.notify("Sign column hidden", vim.log.levels.INFO)
	else
		vim.opt.signcolumn = "yes"
		vim.notify("Sign column shown", vim.log.levels.INFO)
	end
end

local function toggle_hex()
	if vim.b.hex_mode then
		vim.cmd("%!xxd -r")
		vim.bo.filetype = vim.b.hex_prev_ft or ""
		vim.b.hex_mode = nil
		vim.b.hex_prev_ft = nil
	else
		vim.b.hex_prev_ft = vim.bo.filetype
		vim.cmd("%!xxd")
		vim.bo.filetype = "xxd"
		vim.b.hex_mode = true
	end
end

local function toggle_background()
	if vim.o.background == "dark" then
		vim.o.background = "light"
	else
		vim.o.background = "dark"
	end
	local cs = vim.g.colors_name
	if cs and cs ~= "" then
		vim.cmd.colorscheme(cs)
	end
end

vim.keymap.set("n", "<leader>;", "<cmd>FzfLua commands<CR>", { desc = "Command palette" })

-- buffers
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<cr>", {desc = "next buffer"})
vim.keymap.set("n", "<leader>bp", "<cmd>bprev<cr>", {desc = "prev buffer"})
vim.keymap.set("n", "<leader>bd", "<cmd>bd<cr>", {desc = "delete buffer"})
-- vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })


-- edit config files
vim.keymap.set("n", "<leader>ca", "<cmd>e ~/.config/alacritty/alacritty.toml<cr>", { desc = "alacritty" })
vim.keymap.set("n", "<leader>cb", "<cmd>e ~/.bashrc<cr>", { desc = "bash" })
vim.keymap.set("n", "<leader>cg", "<cmd>e ~/.config/ghostty/config<cr>", { desc = "ghostty" })
vim.keymap.set("n", "<leader>ck", "<cmd>e ~/.config/kitty/kitty.conf<cr>", { desc = "kitty" })
vim.keymap.set("n", "<leader>cz", "<cmd>e ~/.zshrc<cr>", { desc = "zsh" })

-- file
vim.keymap.set("n", "<leader>fs", "<cmd>w<cr>", { desc = "Save File" })

-- Mode
vim.keymap.set("n", "<leader>mtm", "<cmd>Mtm<cr>", { desc = "markdown table" })

-- quit
vim.keymap.set("n", "<leader>qq", "<cmd>q<cr>", { desc = "quit" })

-- Move to window using hjkl>
vim.keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Switch to left window" })
vim.keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Switch to lower window" })
vim.keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Switch to upper window" })
vim.keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Switch to right window" })
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
vim.keymap.set("n", "<leader>ws", "<cmd>split<cr>", { desc = "Horizontal split" })
-- quite/close windows
vim.keymap.set("n", "<leader>wq", "<cmd>q<cr>", { desc = "close window" })
vim.keymap.set("n", "<leader>wo", "<C-w>o", { desc = "Keep only current window" })


-- tabs
vim.keymap.set("n", "<leader>tt", "<cmd>tabnew<cr>", { desc = "new tab" })
vim.keymap.set("n", "<leader>td", "<cmd>tab split<cr>", { desc = "duplicate buffer in new tab" })
vim.keymap.set("n", "<leader>tn", "<cmd>tabnext<cr>", { desc = "next tab" })
vim.keymap.set("n", "<leader>tp", "<cmd>tabprevious<cr>", { desc = "prev tab" })
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<cr>", { desc = "close current tab" })
vim.keymap.set("n", "<leader>to", "<cmd>tabonly<cr>", { desc = "close all other tabs" })
vim.keymap.set("n", "<leader>t>", "<cmd>tabmove +1<cr>", { desc = "move tab right" })
vim.keymap.set("n", "<leader>t<", "<cmd>tabmove -1<cr>", { desc = "move tab left" })
vim.keymap.set("n", "<leader>tl", "<cmd>tabprevious<cr>", { desc = "last tab" })
vim.keymap.set("n", "<leader>t1", "1gt", { desc = "tab 1" })
vim.keymap.set("n", "<leader>t2", "2gt", { desc = "tab 2" })
vim.keymap.set("n", "<leader>t3", "3gt", { desc = "tab 3" })
vim.keymap.set("n", "<leader>t4", "4gt", { desc = "tab 4" })
vim.keymap.set("n", "<leader>t5", "5gt", { desc = "tab 5" })


-- ui
vim.keymap.set("n", "<leader>un", function()
	toggle_option("number", true)
end, { desc = "Toggle line numbers" })
vim.keymap.set("n", "<leader>uN", function()
	toggle_option("relativenumber", true)
end, { desc = "Toggle relative line numbers" })
vim.keymap.set("n", "<leader>us", toggle_signcolumn, { desc = "Toggle Sign Column" })
vim.keymap.set("n", "<leader>ui", function()
	toggle_option("list")
end, { desc = "Toggle Indent Guides" })

vim.keymap.set("n", "<leader>uh", toggle_hex, { desc = "Toggle hex view" })

-- change background
vim.keymap.set("n", "<leader>ub", toggle_background, { desc = "Toggle background (dark/light)" })


-- stop issues with recording
vim.keymap.set("n", "q", "<nop>")
vim.keymap.set("n", "Q", "q")
