-- NOTE: Import custom modules

-- Appearance options are stored in looks.lua
local looks = require("custom.looks")

-- Keyboard mappings are stored in keymaps.lua
local keymaps = require("custom.keymaps")

-- Options that are more particular to Wezterm
-- are stored in extra
local extra = require("custom.extra")

-- Call wezterm api and build config table
local wez = require("wezterm")
local config = wez.config_builder()

-- NOTE: Start of config setup
looks.set_colors(config)
looks.set_font(config)
looks.set_bg_options(config)
looks.set_tab_bar_options(config)

keymaps.add_keymaps(config)

extra.set_misc_options(config)

return config
