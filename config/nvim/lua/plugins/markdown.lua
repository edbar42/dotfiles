return { -- Plugin to improve viewing Markdown files in Neovim
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
	---@module "render-markdown"
	---@type render.md.UserConfig
	opts = {
		ft = { "markdown" },
		heading = {
			border = true,
			width = "block",
			left_margin = 0.5,
			left_pad = 0.2,
			right_pad = 0.2,
		},
		pipe_table = {
			preset = "double",
		},
	},
}
