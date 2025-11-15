local wez = require("wezterm")

local options = {}

-- Sets custom colorscheme
-- NOTE:
-- Based on the Japanesque colorscheme
-- for the Kitty terminal with
-- different colors for default
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
	local host = os.getenv("HOST")
	config.font = wez.font("CaskaydiaCove NF")
	if host == "thinkpad" then
		config.font_size = 20.0
	else
		config.font_size = 14.0
	end
end

-- Set background options
function options.set_bg_options(config)
	config.window_background_opacity = 0.84
	config.inactive_pane_hsb = {
		saturation = 0.7,
		brightness = 0.4,
	}
end

-- Set tab bar options
function options.set_tab_bar_options(config)
	local LEFT_SEPARATOR = " " .. wez.nerdfonts.ple_pixelated_squares_big
	local RIGHT_SEPARATOR = " " .. wez.nerdfonts.ple_pixelated_squares_big_mirrored
	config.tab_bar_at_bottom = true
	config.enable_tab_bar = true
	config.show_new_tab_button_in_tab_bar = false
	config.use_fancy_tab_bar = false
	config.hide_tab_bar_if_only_one_tab = true
	config.colors = {
		tab_bar = {
			background = "#1F1F28",
		},
	}
	config.tab_max_width = 25

	-- Add a helper function to get the correct title
	local function get_tab_title(tab)
		local title = tab.tab_title
		-- Use the custom title if it exists
		if title and #title > 0 then
			return title
		end
		-- Otherwise fall back to the pane title
		return tab.active_pane.title
	end

	wez.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
		local title = get_tab_title(tab)
		if tab.is_active then
			return {
				{ Background = { Color = "#2a2a37" } },
				{ Foreground = { Color = "#44dd44" } },
				{ Text = LEFT_SEPARATOR },
				{ Text = "  " .. title },
				{ Text = RIGHT_SEPARATOR },
			}
		else
			return {
				{ Background = { Color = "#16161d" } },
				{ Foreground = { Color = "#727169" } },
				{ Text = LEFT_SEPARATOR },
				{ Text = "  " .. title },
				{ Text = RIGHT_SEPARATOR },
			}
		end
	end)
end

-- Set window options
function options.set_window_options(config)
	config.window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	}
end

return options
