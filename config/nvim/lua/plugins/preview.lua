return { -- Neovim wrapper around MD-TUI
	"henriklovhaug/Preview.nvim",
	cmd = { "Preview" },
	config = function()
		require("preview").setup()
	end,
}

