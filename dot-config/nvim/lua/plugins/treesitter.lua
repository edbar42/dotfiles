return { -- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"latex-lsp/tree-sitter-latex",
	},
	opts = {
		ensure_installed = { "bash", "c", "go", "html", "lua", "luadoc", "markdown", "vim", "vimdoc", "latex" },
		-- Autoinstall languages that are not installed
		auto_install = true,
		highlight = {
			enable = true,
		},
		indent = { enable = true, disable = { "ruby", "python" } },
	},
	config = function(_, opts)
		---@diagnostic disable-next-line: missing-fields
		require("nvim-treesitter.configs").setup(opts)
	end,
}
