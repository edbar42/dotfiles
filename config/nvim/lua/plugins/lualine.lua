return { -- NeoVim status line written in Lua
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		local nvim = function()
			return ""
		end

		require("lualine").setup({
			options = {
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				globalstatus = true,
			},
			sections = {
				lualine_a = { { nvim } },
				lualine_b = { "mode" },
				lualine_c = { "filetype", "filename" },
				lualine_x = { "branch", "diff", "diagnostics" },
				lualine_y = { "fileformat" },
				lualine_z = { "progress", "location" },
			},
		})
	end,
}
