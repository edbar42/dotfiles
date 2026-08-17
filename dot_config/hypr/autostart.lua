-- Extra autostart processes.
hl.on("hyprland.start", function()
    hl.exec_cmd("fcitx5 --replace -d")
    hl.exec_cmd("awww-daemon")
end)
