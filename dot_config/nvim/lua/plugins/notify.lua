return { -- A fancy, configurable, notification manager for NeoVim
	"rcarriga/nvim-notify",
	config = function()
		require("notify").setup({
			timeout = 2000,
			stages = "static",
			render = "wrapped-compact",
			icons = {
				ERROR = "",
				WARN = "",
				INFO = "",
				DEBUG = "",
				TRACE = "✎",
			},
			top_down = false,
			position = "top_right",
		})
	end,
}

