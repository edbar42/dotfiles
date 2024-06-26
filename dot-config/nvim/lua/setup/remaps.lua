-- Set space as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Move between buffers
vim.keymap.set("n", "<C-a>", ":bprev<CR>", { desc = "Go to previous buffer" })
vim.keymap.set("n", "<C-x>", ":bnext<CR>", { desc = "Go to next buffer" })

-- Increment/decrement
vim.keymap.set("n", "+", "<C-a>", { desc = "Increase number under cursor" })
vim.keymap.set("n", "-", "<C-x>", { desc = "Decrease number under cursor" })

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Drag line up" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Drag line down" })

vim.keymap.set("v", "<leader>y", '"+Y', { desc = "Copy highlighted content to clipboard" })

-- Copy buffer content to clipboard
vim.keymap.set("n", "<A-a>", 'gg<S-v>G"+Y', { desc = "Copy buffer content to clipboard" })

-- Replace word under cursor throughout the whole buffer using <leader> + rs
vim.keymap.set(
	"n",
	"<leader>rs",
	[[:%s\/<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace word under cursor in the whole buffer" }
)

-- Keep cursor in place when joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor in line when scrolling search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Clear search query Highlight
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "U", "<C-R>", { desc = "Redo last action" })

-- Better window navigation mappings
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to split below" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to split above" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to split on the left" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to split on the right" })

-- Diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>,e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>,q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Open a terminal at the bottom of the screen with a fixed height.
vim.keymap.set("n", "<leader>tt", function()
	vim.cmd.new()
	vim.api.nvim_win_set_height(0, 14)
	vim.wo.winfixheight = true
	vim.cmd.term()
end)

-- Easily hit escape in terminal mode.
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
