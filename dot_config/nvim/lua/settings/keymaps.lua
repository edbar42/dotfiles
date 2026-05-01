-- Set space as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Drag line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Drag line up" })

vim.keymap.set("v", "<leader>y", '"+y', { desc = "Copy highlighted content to clipboard" })
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Copy highlighted content to clipboard" })
vim.keymap.set("n", "<leader>Y", 'ggVG"+y', { desc = "Copy current buffer's content to clipboard" })

-- Keep cursor in place when joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor in line when scrolling search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "U", "<C-R>", { desc = "Redo last action" })

-- Extend Ctrl-a/Ctrl-x to toggle booleans
local bool_toggles = { ["true"] = "false", ["false"] = "true", ["True"] = "False", ["False"] = "True" }
vim.keymap.set("n", "<C-a>", function()
	local word = vim.fn.expand("<cword>")
	if bool_toggles[word] then
		vim.cmd("normal! ciw" .. bool_toggles[word])
	else
		vim.cmd("normal! \x01")
	end
end, { desc = "Increment number or toggle boolean" })
vim.keymap.set("n", "<C-x>", function()
	local word = vim.fn.expand("<cword>")
	if bool_toggles[word] then
		vim.cmd("normal! ciw" .. bool_toggles[word])
	else
		vim.cmd("normal! \x18")
	end
end, { desc = "Decrement number or toggle boolean" })

-- Print current file path
vim.keymap.set("n", "<leader>pwd", function()
	print(vim.fn.expand("%:p:h"))
end, { desc = "Print current file directory" })

-- Better window navigation/interaction mappings
vim.keymap.set("n", "<leader>vv", function()
	vim.cmd("vsp")
	require("fzf-lua").files()
end, { desc = "Start vertical split" })

vim.keymap.set("n", "<leader>hh", function()
	vim.cmd("sp")
	require("fzf-lua").files()
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

-- TODO comments keybinds
vim.keymap.set("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "TODO: Next todo comment" })

vim.keymap.set("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "TODO: Previous todo comment" })
