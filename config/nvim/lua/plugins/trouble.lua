return { -- Get diagnostic messages project wide
	"folke/trouble.nvim",
	opts = {
		auto_close = true,
		focus = true,
		follow = true,
	}, -- for default options, refer to the configuration section for custom setup.
	cmd = "Trouble",
	keys = {
		{
			"<leader>tt",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = " Toggle trouble diagnostics",
		},
	},
}
