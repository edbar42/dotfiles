-- Autostart necessary processes
local QUICKSHELL_ENV = "OMARCHY_PATH=" .. os.getenv("HOME") .. "/.config/omarchy PATH=" .. os.getenv("HOME") .. "/.config/omarchy/bin:$PATH"
local QUICKSHELL_CMD = "env " .. QUICKSHELL_ENV .. " quickshell -p " .. os.getenv("HOME") .. "/.config/omarchy/shell/shell.qml"

hl.on("hyprland.start", function()
    hl.exec_cmd("fcitx5 --replace -d")
    hl.exec_cmd(QUICKSHELL_CMD)
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
end)
