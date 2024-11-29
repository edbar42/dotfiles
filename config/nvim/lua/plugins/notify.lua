return { -- A fancy, configurable, notification manager for NeoVim
	"rcarriga/nvim-notify",
	config = function()
		require("notify").setup({
			stages = "fade_in_slide_out",
			render = "wrapped-compact",
			icons = {
				ERROR = "",
				WARN = "",
				INFO = "",
				DEBUG = "",
				TRACE = "✎",
			},
			top_down = false,
			position = "bottom_right"
		})
	end,
}
