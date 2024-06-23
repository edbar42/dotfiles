-- Import action directive from wezterm
local wez = require("wezterm")
local a = wez.action

-- Keyboard mappings settings
local options = {}

function options.add_keymaps(config)
	--TODO:
	-- Add keymaps from kitty terminal
	config.keys = {
		-- Spawn a new tab
		{
			key = "t",
			mods = "ALT",
			action = a.SpawnTab("CurrentPaneDomain"),
		},
		-- Switch to the next tab
		{
			key = "n",
			mods = "ALT",
			action = a.ActivateTabRelative(1),
		},
		-- Switch to the previous tab
		{
			key = "p",
			mods = "ALT",
			action = a.ActivateTabRelative(-1),
		},
		-- Spawn a new pane to the right
		{
			key = "Enter",
			mods = "ALT",
			action = a.SplitHorizontal { domain = "CurrentPaneDomain" },
		},
		-- Spawn a new pane below
		{
			key = "Enter",
			mods = "ALT|SHIFT",
			action = a.SplitVertical { domain = "CurrentPaneDomain" },
		},
		-- Quit current pane
		{
			key = "q",
			mods = "ALT",
			action = a.CloseCurrentPane { confirm = true },
		},
		-- Increase font size
		{
			key = "+",
			mods = "ALT|SHIFT",
			action = a.IncreaseFontSize,
		},
		-- Decrease font size
		{
			key = "-",
			mods = "ALT",
			action = a.DecreaseFontSize,
		},
		-- Reset font size to default
		{
			key = "=",
			mods = "ALT",
			action = a.ResetFontSize,
		},
		-- Spawn ranger instance on new tab
		{
			key = "g",
			mods = "ALT",
			action = a.SpawnCommandInNewTab {
				args = { 'yazi' },
			}
		},
	}
end

return options
