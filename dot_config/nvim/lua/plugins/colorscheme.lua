return { -- One dark and light colorscheme for neovim
	"navarasu/onedark.nvim",
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		require("onedark").setup({
			style = "warmer",
			transparent = true,
			term_colors = true,
			cmp_itemkind_reverse = true,
			toggle_style_key = "<leader>cs",
			toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer" },
			code_style = {
				comments = "italic",
				keywords = "bold",
			},
			diagnostics = {
				darker = true,
				undercurl = true,
				background = true,
			},
		})
		require("onedark").load()
	end,
}
