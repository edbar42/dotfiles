-- Mouse cursor theme
hl.env("HYPRCURSOR_THEME", "rose-pine-hyprcursor")

local background = "rgba(262626ff)"
local surface = "rgba(404040ff)"
local foreground = "rgba(e6e6e6ff)"
local inactive_border = "rgba(404040ff)"
local shadow_color = "rgba(00000066)"
local accent_red = "rgba(e65c5cff)"

local accent_green = "rgba(66cc66ff)"
local accent_yellow = "rgba(ffcc66ff)"
local accent_blue = "rgba(6699ffff)"
local accent_magenta = "rgba(cc66ccff)"
local accent_cyan = "rgba(66ccccff)"

hl.config({
    general = {
        gaps_in = 4,
        gaps_out = 6,
        border_size = 0,

        col = {
            active_border   = accent_magenta,
            inactive_border = inactive_border,
        },

        resize_on_border        = true,
        extend_border_grab_area = 15,
        allow_tearing            = false,
        layout                   = "dwindle",
    },

    decoration = {
        rounding = 10,

        shadow = {
            enabled        = true,
            range          = 16,
            render_power   = 3,
            color          = shadow_color,
            color_inactive = shadow_color,
            offset         = { 0, 0 },
        },

        blur = {
            enabled           = true,
            size              = 6,
            passes            = 3,
            contrast          = 1.5,
            brightness        = 0.8,
            vibrancy          = 0.2,
            vibrancy_darkness = 0.2,
            noise             = 0.07,
            ignore_opacity    = true,
            new_optimizations = true,
        },

        active_opacity     = 1,
        inactive_opacity   = 0.8,
        fullscreen_opacity = 1.0,
    },

    animations = {
        enabled = true,
    },

    misc = {
        background_color = background,
    },
})

hl.curve("snappy",   { type = "bezier", points = { { 0.25, 0.46 }, { 0.45, 0.94 } } })
hl.curve("smooth",   { type = "bezier", points = { { 0.23, 1 },    { 0.32, 1 } } })
hl.curve("slide",    { type = "bezier", points = { { 0.165, 0.84 }, { 0.44, 1 } } })
hl.curve("overshot", { type = "bezier", points = { { 0.13, 0.99 }, { 0.29, 1.1 } } })

hl.animation({ leaf = "windows",          enabled = true, speed = 4, bezier = "snappy",   style = "slide" })
hl.animation({ leaf = "windowsIn",        enabled = true, speed = 4, bezier = "overshot", style = "popin 85%" })
hl.animation({ leaf = "windowsOut",       enabled = true, speed = 3, bezier = "snappy",   style = "popin 85%" })
hl.animation({ leaf = "windowsMove",      enabled = true, speed = 4, bezier = "snappy" })
hl.animation({ leaf = "fade",             enabled = true, speed = 5, bezier = "smooth" })
hl.animation({ leaf = "fadeIn",           enabled = true, speed = 4, bezier = "smooth" })
hl.animation({ leaf = "fadeOut",          enabled = true, speed = 3, bezier = "smooth" })
hl.animation({ leaf = "workspaces",       enabled = true, speed = 3, bezier = "smooth",   style = "fade" })
hl.animation({ leaf = "border",           enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "borderangle",      enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "layersIn",         enabled = true, speed = 3, bezier = "smooth",   style = "popin 85%" })
hl.animation({ leaf = "layersOut",        enabled = true, speed = 2, bezier = "snappy",   style = "popin 85%" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3, bezier = "overshot", style = "fade" })
