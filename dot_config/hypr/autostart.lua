-- Autostart necessary processes
hl.on("hyprland.start", function()
    hl.exec_cmd("fcitx5 --replace -d")
    hl.exec_cmd("env waybar")
    hl.exec_cmd("swaync")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
end)
