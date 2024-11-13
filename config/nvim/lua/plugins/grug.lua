return { -- Find and replace plugin for neovim
	"MagicDuck/grug-far.nvim",
	config = function()
		require("grug-far").setup({})
	end,
}
