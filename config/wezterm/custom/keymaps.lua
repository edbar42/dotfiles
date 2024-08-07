-- Import action directive from wezterm
local wez = require("wezterm")
local a = wez.action

-- Keyboard mappings settings
local options = {}

function options.add_keymaps(config)
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
			action = a.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		-- Spawn a new pane below
		{
			key = "Enter",
			mods = "ALT|SHIFT",
			action = a.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		-- Quit current pane
		{
			key = "q",
			mods = "ALT",
			action = a.CloseCurrentPane({ confirm = true }),
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
		-- Spawn yazi instance on new tab
		{
			key = "g",
			mods = "ALT",
			action = a.SpawnCommandInNewTab({
				args = { "yazi" },
			}),
		},
		{
			key = "f",
			mods = "ALT",
			action = a.ShowTabNavigator,
		},
		-- Move to pane with hjkl
		{
			key = "h",
			mods = "ALT",
			action = a.ActivatePaneDirection("Left"),
		},
		{
			key = "j",
			mods = "ALT",
			action = a.ActivatePaneDirection("Down"),
		},
		{
			key = "k",
			mods = "ALT",
			action = a.ActivatePaneDirection("Up"),
		},
		{
			key = "l",
			mods = "ALT",
			action = a.ActivatePaneDirection("Right"),
		},
		-- Resize panes with ALT + SHIFT + hjkl
		{
			key = "h",
			mods = "ALT|SHIFT",
			action = a.AdjustPaneSize({ "Left", 5 }),
		},
		{
			key = "j",
			mods = "ALT|SHIFT",
			action = a.AdjustPaneSize({ "Down", 5 }),
		},
		{
			key = "k",
			mods = "ALT|SHIFT",
			action = a.AdjustPaneSize({ "Up", 5 }),
		},
		{
			key = "l",
			mods = "ALT|SHIFT",
			action = a.AdjustPaneSize({ "Right", 5 }),
		},
	}
end

return options
