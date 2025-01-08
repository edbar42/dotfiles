-- NOTE:
-- Holds settings specific to WezTerm

local options = {}

function options.set_misc_options(config)
	config.audible_bell = "Disabled"
	config.enable_kitty_graphics = true
	config.prefer_to_spawn_tabs = false
	config.log_unknown_escape_sequences = true
	config.allow_square_glyphs_to_overflow_width = "Never"
	config.adjust_window_size_when_changing_font_size = false
	config.skip_close_confirmation_for_processes_named = {
		"yazi",
		"zsh",
	}
end

return options
