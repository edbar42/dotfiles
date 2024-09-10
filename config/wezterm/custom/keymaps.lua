-- Import action directive from wezterm
local wez = require("wezterm")
local a = wez.action

local options = {}

-- Keyboard mappings settings
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
		-- Maximize current pane
		{
			key = "m",
			mods = "ALT",
			action = a.TogglePaneZoomState,
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
		-- Disable equivalent binding
		{ key = "-", mods = "CTRL", action = a.DisableDefaultAssignment },
		-- Reset font size to default
		{
			key = "=",
			mods = "ALT",
			action = a.ResetFontSize,
		},
		-- Disable equivalent binding
		{ key = "=", mods = "CTRL", action = a.DisableDefaultAssignment },
		{ key = "+", mods = "CTRL", action = a.DisableDefaultAssignment },
		-- Activate copy mode
		{
			key = "v",
			mods = "ALT",
			action = a.ActivateCopyMode,
		},
		-- Spawn yazi instance on new tab
		{
			key = "g",
			mods = "ALT",
			action = a.SpawnCommandInNewTab({
				args = { "yazi" },
			}),
		},
		-- Spawn quick switcher/workspace launcher
		{
			key = "f",
			mods = "ALT",
			action = a.ShowLauncherArgs({ flags = "FUZZY|TABS" }),
		},
		-- Rename current tab
		{
			key = "r",
			mods = "ALT",
			action = a.PromptInputLine({
				description = "Enter new name",
				action = wez.action_callback(function(window, pane, line)
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
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
