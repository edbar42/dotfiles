-- NOTE: Import custom modules
-- Appearance -> custom/looks.lua
-- Keymaps -> custom/keymaps.lua
-- Wezterm specific -> custom/extra.lua

local looks = require("custom.looks")
local keymaps = require("custom.keymaps")
local extra = require("custom.extra")

-- Call wezterm api and build config table
local wez = require("wezterm")
local config = wez.config_builder()

looks.set_colors(config)
looks.set_font(config)
looks.set_bg_options(config)
looks.set_tab_bar_options(config)

keymaps.add_keymaps(config)

extra.set_misc_options(config)
extra.laucher_options(config)

return config
