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

	-- <leader> + gc to comment lines
	{ 'numToStr/Comment.nvim', opts = {} },
	-- Highlight todo, notes, etc in comments
	{ 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },


	-- More extensive plugins
	--
	-- I keep switching colorschemes
	-- Stop judging me
	
	-- require('plugins.tokyonight'),
	require('plugins.kanagawa'),
	require('plugins.lualine'),
	require('plugins.gitsigns'),
	require('plugins.fugitive'),
	require('plugins.whichkey'),
	require('plugins.telescope'),
	require('plugins.treesitter'),
	require('plugins.harpoon'),
	-- TODO: Fix lsp not working when called from a separate file
	require('plugins.lsp'),
}, opts)
