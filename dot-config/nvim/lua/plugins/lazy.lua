local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- One liners

	-- gc to comment lines in visual mode
	{ "numToStr/Comment.nvim", opts = {} },

	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	-- More extensive plugins
	require("plugins.kanagawa"),
	require("plugins.lualine"),
	require("plugins.gitsigns"),
	require("plugins.fugitive"),
	require("plugins.whichkey"),
	require("plugins.telescope"),
	require("plugins.treesitter"),
	require("plugins.harpoon"),
	require("plugins.lsp"),
}, opts)
