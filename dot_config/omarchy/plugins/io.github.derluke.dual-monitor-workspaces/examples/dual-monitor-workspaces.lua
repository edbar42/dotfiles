-- Opt-in example for ~/.config/hypr/bindings.lua.
-- Review and replace these with names from `hyprctl monitors`.
local first_monitor = "DP-1"
local second_monitor = "DP-2"
local workspace_count = 5

-- Install the matching release branch first, for example:
--   git clone --branch release/0.56.x --single-branch \
--     https://github.com/zjeffer/split-monitor-workspaces.git \
--     ~/.config/hypr/plugins/split-monitor-workspaces
local hypr_config_dir = (os.getenv("HOME") or "") .. "/.config/hypr"
package.path = package.path
  .. ";" .. hypr_config_dir .. "/?.lua"
  .. ";" .. hypr_config_dir .. "/?/init.lua"

local smw = require("plugins.split-monitor-workspaces")

smw.setup({
  workspace_count = workspace_count,
  monitor_priority = { first_monitor, second_monitor },
  keep_focused = true,
  enable_persistent_workspaces = true,
  enable_notifications = false,
  enable_wrapping = true,
})

-- Seed the map when this module loads after Hyprland's monitor-added events.
local smw_helpers = require("plugins.split-monitor-workspaces.lua.helpers")
local smw_monitors = require("plugins.split-monitor-workspaces.lua.monitors")
hl.timer(function()
  smw_helpers.load_config_for_all_monitors()
  smw_monitors.remap_all_monitors()
end, { timeout = 50, type = "oneshot" })

-- Remove Omarchy's global numbered-workspace bindings so keys outside 1..5
-- cannot leak into the other monitor's workspace bank.
for workspace = 1, 10 do
  local key = "code:" .. tostring(workspace + 9)
  hl.unbind("SUPER + " .. key)
  hl.unbind("SUPER + SHIFT + " .. key)
  hl.unbind("SUPER + SHIFT + ALT + " .. key)
end

for local_workspace = 1, workspace_count do
  local key = "code:" .. tostring(local_workspace + 9)
  local first_workspace = tostring(local_workspace)
  local second_workspace = tostring(local_workspace + workspace_count)

  -- SUPER+CTRL+1..5 normally opens Quattro bar panels. Override those keys.
  hl.unbind("SUPER + CTRL + " .. key)

  o.bind("SUPER + " .. key, "Switch to " .. first_monitor .. " workspace " .. local_workspace,
    hl.dsp.focus({ workspace = first_workspace }))
  o.bind("SUPER + SHIFT + " .. key, "Move window to " .. first_monitor .. " workspace " .. local_workspace,
    hl.dsp.window.move({ workspace = first_workspace }))
  o.bind("SUPER + SHIFT + ALT + " .. key, "Move window silently to " .. first_monitor .. " workspace " .. local_workspace,
    hl.dsp.window.move({ workspace = first_workspace, follow = false }))

  o.bind("SUPER + CTRL + " .. key, "Switch to " .. second_monitor .. " workspace " .. local_workspace,
    hl.dsp.focus({ workspace = second_workspace }))
  o.bind("SUPER + CTRL + SHIFT + " .. key, "Move window to " .. second_monitor .. " workspace " .. local_workspace,
    hl.dsp.window.move({ workspace = second_workspace }))
  o.bind("SUPER + CTRL + SHIFT + ALT + " .. key, "Move window silently to " .. second_monitor .. " workspace " .. local_workspace,
    hl.dsp.window.move({ workspace = second_workspace, follow = false }))
end

hl.unbind("SUPER + TAB")
hl.unbind("SUPER + SHIFT + TAB")
o.bind("SUPER + TAB", "Next workspace on current monitor", smw.cycle_workspaces("next"))
o.bind("SUPER + SHIFT + TAB", "Previous workspace on current monitor", smw.cycle_workspaces("prev"))

local function move_window_to_adjacent_monitor(direction)
  return function()
    local current = hl.get_active_monitor()
    local window = hl.get_active_window()
    if not current or not window then return end

    local target = nil
    for _, monitor in ipairs(hl.get_monitors()) do
      local is_candidate = direction == "l" and monitor.x < current.x
        or direction == "r" and monitor.x > current.x

      if is_candidate and (not target
          or direction == "l" and monitor.x > target.x
          or direction == "r" and monitor.x < target.x) then
        target = monitor
      end
    end

    if target then
      hl.dispatch(hl.dsp.window.move({ monitor = target.name }))
    end
  end
end

hl.unbind("SUPER + CTRL + SHIFT + LEFT")
hl.unbind("SUPER + CTRL + SHIFT + RIGHT")
o.bind("SUPER + CTRL + SHIFT + LEFT", "Send window to left monitor",
  move_window_to_adjacent_monitor("l"))
o.bind("SUPER + CTRL + SHIFT + RIGHT", "Send window to right monitor",
  move_window_to_adjacent_monitor("r"))
