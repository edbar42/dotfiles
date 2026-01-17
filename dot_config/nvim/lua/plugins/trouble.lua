return { -- Get diagnostic messages project wide
	"folke/trouble.nvim",
	opts = {
		auto_close = true,
		focus = true,
		follow = true,
	},
	cmd = "Trouble",
	keys = {
		{
			"<leader>tt",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Trouble: Toggle trouble diagnostics",
		},
		{
			"<leader>qf",
			"<cmd>Trouble quickfix toggle<cr>",
			desc = "Trouble: Toggle trouble quickfix list",
		},
	},
}
