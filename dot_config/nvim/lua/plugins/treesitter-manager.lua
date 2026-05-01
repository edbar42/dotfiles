return { -- A lightweight Tree-sitter parser manager for Neovim
	"romus204/tree-sitter-manager.nvim",
	dependencies = {}, -- tree-sitter CLI must be installed system-wide
	config = function()
		require("tree-sitter-manager").setup({
			-- Default Options
			ensure_installed = {
				"c_sharp",
				"go",
				"gomod",
				"gowork",
				"gosum",
				"javascript",
				"json",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"typescript",
				"tsx",
				"vim",
				"vimdoc",
			}, -- list of parsers to install at the start of a neovim session
			auto_install = true, -- if enabled, install missing parsers when editing a new file
		})
	end,
}
