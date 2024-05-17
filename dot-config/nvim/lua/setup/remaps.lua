-- Set space as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "Q", ":q<CR>", { desc = "Quick quit a buffer or window" })

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Drag line up" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Drag line down" })

-- Keep cursor in place when joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor in line when scrolling search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>y", '"+y', { desc = "Copy highlighted content to clipboard" })
vim.keymap.set("n", "<leader>cp", 'ggVG"+Y', { desc = "Copy buffer to clipboard" })

-- Replace word under cursor throughout the whole buffer using <leader> + rs
vim.keymap.set(
	"n",
	"<leader>rs",
	[[:%s\/<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace word under cursor in the whole buffer" }
)

vim.keymap.set("n", "U", "<C-R>", { desc = "Redo last action" })

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>,e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>,q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
