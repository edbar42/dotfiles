return { -- Plugin to improve viewing Markdown files in Neovim
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
	---@module "render-markdown"
	---@type render.md.UserConfig
	opts = {
		ft = { "markdown" },
		heading = {
			border = true,
			width = "block",
			left_pad = 0.1,
			right_pad = 0.1,
		},
		pipe_table = {
			preset = "double",
		},
	},
}
