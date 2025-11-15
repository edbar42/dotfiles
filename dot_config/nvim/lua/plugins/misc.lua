return { -- Non-extensive config plugins

	-- Manage surrouding elements
	{ "tpope/vim-surround" },

	-- Highlight todo, notes, etc in comments
	{ "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },

	-- Mini pairs: minimal and fast autopairs
	{ "nvim-mini/mini.pairs", version = "*", opts = {} },

	-- Elixir syntax highlighting
	{ "elixir-editors/vim-elixir" },

	-- Automatically add closing tags for HTML and JSX
	{ "windwp/nvim-ts-autotag", opts = {} },

	-- A hackable previewer for Neovim
	{ "OXY2DEV/markview.nvim", lazy = false, priority = 49, dependencies = { "saghen/blink.cmp" } },

	{ -- The fastest Neovim colorizer
		"NvChad/nvim-colorizer.lua",
		opts = {
			user_default_options = {
				names = false,
				RRGGBBAA = true,
				rgb_fn = true,
				mode = "virtualtext",
				tailwind = true,
				virtualtext = "",
				always_update = true,
			},
		},
	},

	{ -- Enhance Neovim's native comments
		"folke/ts-comments.nvim",
		event = "VeryLazy",
		opts = {},
	},

	{ -- Faster LuaLS  setup for Neovim
		"folke/lazydev.nvim",
		ft = "lua",
		cmd = "LazyDev",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "LazyVim", words = { "LazyVim" } },
				{ path = "snacks.nvim", words = { "Snacks" } },
				{ path = "lazy.nvim", words = { "LazyVim" } },
			},
		},
	},

	{ -- Search and replace in multiple files
		"MagicDuck/grug-far.nvim",
		opts = { headerMaxWidth = 80 },
		cmd = { "GrugFar", "GrugFarWithin" },
		keys = {
			{
				"<leader>sr",
				function()
					local grug = require("grug-far")
					local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
					grug.open({
						transient = true,
						prefills = {
							filesFilter = ext and ext ~= "" and "*." .. ext or nil,
						},
					})
				end,
				mode = { "n", "x" },
				desc = "Search and Replace",
			},
		},
	},
}
