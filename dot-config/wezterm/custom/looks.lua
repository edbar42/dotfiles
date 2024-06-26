-- Importing wezterm api
local wez = require("wezterm")

-- The table that will hold our custom settings
local options = {}

-- Sets custom colorscheme
-- NOTE:
-- Based on the Japanesque colorscheme
-- for the Kitty terminal.My changes are
-- simply different colors for default
-- text and highlighting
-- Original colorscheme:
-- https://github.com/dexpota/kitty-themes/blob/master/themes/Japanesque.conf
--
function options.set_colors(config)
	-- Set custom colorscheme
	config.colors = {
		-- Default colors
		background = "#1d1d1d",
		foreground = "#dcd7ba",
		cursor_bg = "#155776",
		selection_bg = "#eccf4f",
		selection_fg = "#1d1d1d",

		-- ANSI colors
		ansi = {
			"#343835", -- black
			"#ce3e60", -- red
			"#7bb75b", -- green
			"#e8b32a", -- yellow
			"#4c99d3", -- blue
			"#a57fc4", -- magenta
			"#389aac", -- cyan
			"#f9faf6", -- white
		},

		-- Bright colors
		brights = {
			"#585a58", -- black
			"#ce3e60", -- red
			"#7bb75b", -- green
			"#e8b32a", -- yellow
			"#4c99d3", -- blue
			"#a57fc4", -- magenta
			"#389aac", -- cyan
			"#f9faf6", -- white
		},
	}
end

-- Set favorite font
function options.set_font(config)
	config.font = wez.font("CaskaydiaCove Nerd Font")
	config.font_size = 14.0
end

-- Set background options
function options.set_bg_options(config)
	config.window_background_opacity = 0.90
	config.inactive_pane_hsb = {
		saturation = 0.7,
		brightness = 0.4,
	}
end

-- Set tab bar options
function options.set_tab_bar_options(config)
	config.tab_bar_at_bottom = true
	config.hide_tab_bar_if_only_one_tab = true
	config.show_new_tab_button_in_tab_bar = false
	config.use_fancy_tab_bar = false
end

return options
