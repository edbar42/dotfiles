return { -- Neovim file explorer
	"stevearc/oil.nvim",
	opts = {},
	dependencies = { "nvim-tree/nvim-web-devicons" },

	config = function()
		require("oil").setup({
			default_file_explorer = true,
			win_options = {
				wrap = true,
				signcolumn = "yes",
			},

			skip_confirm_for_simple_edits = true,
			watch_for_changes = true,

			keymaps = {
				["?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["q"] = "actions.close",
				["h"] = "actions.parent",
				["<C-h>"] = "actions.toggle_hidden",
			},

			view_options = { show_hidden = true },
			float = {
				win_options = { winblend = 5 },
				preview_split = "right",
			},
		})

		vim.keymap.set("n", "<leader>ff", require("oil").toggle_float)
	end,
}
