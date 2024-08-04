return { -- Non-extensive config plugins

	-- Comment lines in visual mode
	{ "numToStr/Comment.nvim", opts = {} },

	-- Manage surrouding elements
	{ "tpope/vim-surround" },

	-- Git wrapper for neovim
	{
		"tpope/vim-fugitive",
		vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git (Fugitive) status" })
	},

	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},

	-- Elixir syntax highlighting
	{ "elixir-editors/vim-elixir" },
}
