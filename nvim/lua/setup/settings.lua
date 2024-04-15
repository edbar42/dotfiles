-- Block cursor in all modes
vim.opt.guicursor = ""

-- Highlight current line
vim.opt.cursorline = true

-- Set default colorscheme with
-- transparent background if
-- none is provided via plugin
vim.opt.background = "dark"
vim.cmd("colorscheme habamax")
vim.cmd("hi Normal guibg=NONE ctermbg=NONE")

-- Show files in tree on netrw
vim.g.netrw_liststyle = 3

-- Numbered and relative lines
vim.opt.nu = true
vim.opt.relativenumber = true

-- Identation options
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
-- Show identation levels
-- vim.g.ident_blankline_enabled = 1

-- Confirmation pop-up for
-- quit without saving
vim.opt.confirm = true

-- Hilighting and inclusive
-- search
vim.opt.hlsearch = true
vim.opt.incsearch = true
-- Case insensitive search
-- unless using capital
-- letters or \C
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Improves color compatibility
vim.opt.termguicolors = true

-- How many lines to keep above
-- and below cursor when scrolling
vim.opt.scrolloff = 15

-- Reasonable window splitting settings
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Keep an undo history file
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Set time for file to be written to
-- disk after inactivity in ms
vim.opt.updatetime = 250

-- Show some whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
