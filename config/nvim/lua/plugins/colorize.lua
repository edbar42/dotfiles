return { --the fastest Neovim colorizer
	"NvChad/nvim-colorizer.lua",
	config = function()
		require("colorizer").setup({
			user_default_options = {
				names = false,
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				rgb_fn = true, -- CSS rgb() and rgba() functions
				mode = "virtualtext", -- Set the display mode.
				tailwind = true, -- Enable tailwind colors
				virtualtext = "󰪥",
				always_update = true,
			},
		})
	end,
}
