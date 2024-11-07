-- Set space as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Drag line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Drag line up" })

vim.keymap.set("v", "<leader>y", '"+Y', { desc = "Copy highlighted content to clipboard" })

-- Keep cursor in place when joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor in line when scrolling search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "U", "<C-R>", { desc = "Redo last action" })

-- Better window navigation/interaction mappings
vim.keymap.set("n", "<leader>vv", function()
	vim.cmd("vsp")
	require('telescope.builtin').find_files()
end, { desc = "Start vertical split" })

vim.keymap.set("n", "<leader>hh", function()
	vim.cmd("sp")
	require('telescope.builtin').find_files()
end, { desc = "Start horizontal split" })

vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to split below" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to split above" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to split on the left" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to split on the right" })

vim.keymap.set("n", "<C-q>", "<C-w>q", { desc = "Close focused window" })
vim.keymap.set("n", "<C-r>", "<C-w>r", { desc = "Rotate windows" })

vim.keymap.set("n", "<C-=>", "<C-w>=", { desc = "Resize windows to fit screen" })
vim.keymap.set("n", "<C-+>", "<C-w>+", { desc = "Increase window height" })
vim.keymap.set("n", "<C-->", "<C-w>-", { desc = "Decrease window height" })
vim.keymap.set("n", "<C->>", "<C-w>>", { desc = "Increase window width" })
vim.keymap.set("n", "<C-<>", "<C-w><", { desc = "Decrease window width" })

-- Diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>,e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>,q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
