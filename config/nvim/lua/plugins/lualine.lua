return { -- NeoVim status line written in Lua
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		local function custom_mode()
			local mode_code = vim.api.nvim_get_mode().mode
			local custom_map = {
				["n"] = "",
				["i"] = "",
				["v"] = "",
				["V"] = " -LINE",
				["\22"] = " -BLOCK",
				["c"] = "",
			}

			return custom_map[mode_code] or require("lualine.utils.mode").get_mode()
		end

		require("lualine").setup({
			options = {
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				globalstatus = true,
				theme = "codedark",
			},
			sections = {
				lualine_a = { custom_mode },
				lualine_b = { "filetype" },
				lualine_c = { "filename" },
				lualine_x = { "branch", "diff", "diagnostics" },
				lualine_y = { "fileformat" },
				lualine_z = { "progress", "location" },
			},
		})
	end,
}
