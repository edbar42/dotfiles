return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup {
			open_mapping = "<leader>tr",
			hide_numbers = true,
		}
	end
}
