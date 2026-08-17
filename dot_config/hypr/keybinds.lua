-- Custom applications variables
local BROWSER = "zen-browser"
local DEV_BROWSER = "chromium"
local TERMINAL = "/usr/bin/ghostty"
local FILE_MANAGER = "nautilus"
local CLI_FILE_MANAGER = "ghostty -e /usr/bin/yazi"
local SCRIPTS_DIR = "~/.bin/"
local QUICKSHELL_LAUNCHER = "omarchy-shell shell toggle omarchy.menu '{\"menu\":\"apps\"}'"

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Open applications
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(TERMINAL .. " -e herdr"))
hl.bind(mainMod .. " + ALT + Return", hl.dsp.exec_cmd(TERMINAL))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(BROWSER))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(DEV_BROWSER))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("obsidian"))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd(CLI_FILE_MANAGER))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(FILE_MANAGER))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("env GDK_BACKEND=x11 keepassxc"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("rider"))
hl.bind("Print", hl.dsp.exec_cmd("flameshot gui"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(QUICKSHELL_LAUNCHER))
hl.bind(mainMod .. " + U", hl.dsp.exec_cmd("ghostty -e oxker"))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("hyprctl switchxkblayout keyd-virtual-keyboard next"))

-- Custom actions
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(SCRIPTS_DIR .. "tui-float " .. SCRIPTS_DIR .. "wallpaper-fzf -s main"))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd(SCRIPTS_DIR .. "tui-float " .. SCRIPTS_DIR .. "wallpaper-fzf -s secondary"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("omarchy-shell shell summon omarchy.menu '{\"menu\":\"system\"}'"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("hyprlock-wal"))

-- i3 like resize mode
hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
    hl.bind("l", hl.dsp.window.resize({ x = 20, y = 0, relative = true }))
    hl.bind("h", hl.dsp.window.resize({ x = -20, y = 0, relative = true }))
    hl.bind("k", hl.dsp.window.resize({ x = 0, y = -20, relative = true }))
    hl.bind("j", hl.dsp.window.resize({ x = 0, y = 20, relative = true }))
    hl.bind("Return", hl.dsp.submap("reset"))
    hl.bind("Escape", hl.dsp.submap("reset"))
end)

-- Move focus with mainMod + [hjkl]
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "d" }))

-- Switch workspaces with mainMod + [0-9], move windows with mainMod + SHIFT + [0-9]
-- Alt + mainMod + [1-0] -> workspaces 11-20, Alt + mainMod + SHIFT + [1-0] -> move to 11-20
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
    hl.bind("ALT + " .. mainMod .. " + " .. key, hl.dsp.focus({ workspace = i + 10 }))
    hl.bind("ALT + " .. mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i + 10 }))
end

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(SCRIPTS_DIR .. "volume inc"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(SCRIPTS_DIR .. "volume dec"), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(SCRIPTS_DIR .. "volume mute"), { locked = true })
-- hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })

-- Drag floating windows with your mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("omarchy-shell media next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("omarchy-shell media playPause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("omarchy-shell media playPause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("omarchy-shell media previous"), { locked = true })
