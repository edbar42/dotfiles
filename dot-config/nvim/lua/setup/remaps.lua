-- Set space as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Explore files in NeoVim
vim.keymap.set("n", "<leader>ff", vim.cmd.Ex)

-- Move lines in visual mode
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- Keep cursor in place when 
-- joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor in line when 
-- scrolling search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Copy to system clipboard with
-- <leader> + y or <leader> + Y
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Copy all text in file
vim.keymap.set("n", "<A-a>", "ggVG\"+Y")

-- Replace word under cursor 
-- throughout the whole buffer
-- using <leader> + rs
vim.keymap.set(
	"n",
	"<leader>rs",
	[[:%s\/<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]
)

-- Code snippets insertion
vim.keymap.set("n", "<leader>,c", ":-1read $HOME/.config/nvim/snippets/init.c<CR>3ja")
vim.keymap.set("n", "<leader>,g", ":-1read $HOME/.config/nvim/snippets/init.go<CR>5ja")

-- Navigate split screens using
-- <Left-Alt> + hjkl
vim.keymap.set("n", "<A-h>", "<C-w>h")
vim.keymap.set("n", "<A-j>", "<C-w>j")
vim.keymap.set("n", "<A-k>", "<C-w>k")
vim.keymap.set("n", "<A-l>", "<C-w>l")

-- Remaps "redo" to U instead of
-- <Ctrl> + R
vim.keymap.set("n", "U", "<C-R>")

-- Highlight yanked text
local highlight_group = vim.api.nvim_create_augroup(
	'YankHighlight', { clear = true})
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})
