return { -- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		-- Autoinstall languages that are not installed
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "bash", "c", "cpp", "go", "html", "lua", "luadoc", "markdown", "vim", "vimdoc" },
			sync_install = true,
			auto_install = true,
			highlight = {
				enable = true,
			},
			indent = { enable = true, disable = { "ruby", "python", "go" } },
		})
	end,
}
