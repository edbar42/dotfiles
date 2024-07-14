return {
	-- One liners
	-- gc to comment lines in visual mode
	{ "numToStr/Comment.nvim", opts = {} },
	-- manage surrouding elements
	{ "tpope/vim-surround" },
	-- git fugitive for nvim
	{ "tpope/vim-fugitive",    vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git (Fugitive) status" }) },
	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = true },
	},
	-- Add elixir highlighting
	{ "elixir-editors/vim-elixir" },
	-- Undo tree
	{
		"mbbill/undotree",

		config = function()
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
		end
	}

}
