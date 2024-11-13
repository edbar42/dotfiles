return { -- Non-extensive config plugins

	-- Comment lines in visual mode
	{ "numToStr/Comment.nvim", opts = {} },

	-- Manage surrouding elements
	{ "tpope/vim-surround" },

	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},

	-- Elixir syntax highlighting
	{ "elixir-editors/vim-elixir" },

	-- Automatically add closing tags for HTML and JSX
	{
		"windwp/nvim-ts-autotag",
		opts = {},
	},
}
