-- Block cursor in all modes
vim.opt.guicursor = ""

-- Highlight current line
vim.opt.cursorline = true

-- Set default native colorscheme with transparent background
vim.opt.background = "dark"
vim.cmd("colorscheme habamax")
vim.cmd("hi Normal guibg=NONE ctermbg=NONE")

-- Show files in tree on netrw
vim.g.netrw_liststyle = 3

-- Numbered and relative lines
vim.opt.nu = true
vim.opt.relativenumber = true

-- Enable signcolumn
vim.opt.signcolumn = "yes"

-- Identation options
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true

-- Confirmation pop-up for quit without saving
vim.opt.confirm = true

-- Hilighting and inclusive search
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Case insensitive search unless using capital letters or \C
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Clear search query Highlight
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Improves color compatibility
vim.opt.termguicolors = true

-- How many lines to keep above and below cursor when scrolling
vim.opt.scrolloff = 15

-- Reasonable window splitting settings
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Keep an undo history file
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Time for swap to be written to disk
vim.opt.updatetime = 250

-- Time in ms for a mapping to complete
vim.opt.timeoutlen = 300

-- Show some whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Set local settings for terminal buffers
local set = vim.opt_local

vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", {}),
	callback = function()
		set.number = false
		set.relativenumber = false
		set.scrolloff = 0
	end,
})

-- Highlight yanked text
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})
