-- NOTE: to check for actual classnames, use this command
-- hyprctl clients | grep -A 5 APP_NAME

-- floating window rules
hl.window_rule({ match = { class = "yad" }, float = true, center = true })
hl.window_rule({ match = { class = "blueberry.py" }, float = true, center = true })
hl.window_rule({ match = { class = "xsane" }, float = true, center = true })
hl.window_rule({ match = { class = "org.pulseaudio.pavucontrol" }, float = true, center = true })
hl.window_rule({ match = { class = "qt5ct" }, float = true, center = true })
hl.window_rule({ match = { class = "bluetooth-sendto" }, float = true, center = true })
hl.window_rule({ match = { class = "pamac-manager" }, float = true, center = true })
hl.window_rule({ match = { class = "^(org.keepassxc.KeePassXC)$" }, float = true, center = true })
hl.window_rule({
    match = {
        class = "^(org.keepassxc.KeePassXC)$",
        title = "^(KeePassXC -  Access Request)$",
    },
    float  = true,
    center = true,
})

-- flameshot multi-display fix
hl.window_rule({
    match = { class = "flameshot", title = "flameshot" },
    move             = { 0, 0 },
    pin              = true,
    fullscreen_state = "0 2",
    float            = true,
})
