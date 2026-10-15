--------------------
---- VARIABLES -----
--------------------

local mainMod  = "SUPER"
local terminal = "kitty"


------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "",
    mode     = "1920x1080",
    position = "auto",
    scale    = "auto",
})


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user start hypridle")
    hl.exec_cmd("systemctl --user start swaync")
    hl.exec_cmd("systemctl --user start cliphist.service cliphist-images.service")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")


-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        -- Compact spacing, but enough separation to make tiling readable.
        gaps_in  = 4,
        gaps_out = 8,

        -- Slightly stronger than the old 1px border so the active
        -- gradient is actually visible.
        border_size = 2,

        col = {
            active_border = {
                colors = {
                    "rgba(F29AC3FF)", -- pink
                    "rgba(C6A0F6FF)", -- lavender
                    "rgba(8AADF4FF)", -- blue
                },
                angle = 45,
            },

            -- Quiet inactive windows.
            inactive_border = "rgba(292C3C88)",
        },

        resize_on_border = true,
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        -- Entire rice stays square.
        rounding = 0,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,

            -- Visible enough to separate stacked/floating windows,
            -- but not a huge glowing shadow.
            range        = 7,
            render_power = 3,
            color        = 0x99101018,
        },

        blur = {
            enabled = true,

            -- Moderate blur. Two passes is still inexpensive on your 4650U.
            size   = 5,
            passes = 2,

            -- Keep transparent surfaces dark instead of oversaturated.
            vibrancy = 0.08,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
    },
})

--------------------
---- ANIMATIONS ----
--------------------

-- Fast UI response with a soft landing.
hl.curve(
    "snappy",
    {
        type = "bezier",
        points = {
            { 0.20, 1.00 },
            { 0.30, 1.00 },
        },
    }
)

-- Smooth movement without feeling floaty.
hl.curve(
    "smooth",
    {
        type = "bezier",
        points = {
            { 0.40, 0.00 },
            { 0.20, 1.00 },
        },
    }
)

-- Quick fades for overlays and disappearing elements.
hl.curve(
    "fadeFast",
    {
        type = "bezier",
        points = {
            { 0.20, 0.00 },
            { 0.00, 1.00 },
        },
    }
)


-- Global fallback.
hl.animation({
    leaf    = "global",
    enabled = true,
    speed   = 6,
    bezier  = "snappy",
})


-- Windows

hl.animation({
    leaf    = "windows",
    enabled = true,
    speed   = 5,
    bezier  = "snappy",
})

hl.animation({
    leaf    = "windowsIn",
    enabled = true,
    speed   = 5,
    bezier  = "snappy",

    -- Barely perceptible scale-in instead of a dramatic pop.
    style   = "popin 96%",
})

hl.animation({
    leaf    = "windowsOut",
    enabled = true,
    speed   = 4,
    bezier  = "fadeFast",

    style   = "popin 96%",
})


-- Window borders

hl.animation({
    leaf    = "border",
    enabled = true,
    speed   = 5,
    bezier  = "smooth",
})


-- Fades

hl.animation({
    leaf    = "fade",
    enabled = true,
    speed   = 4,
    bezier  = "fadeFast",
})

hl.animation({
    leaf    = "fadeIn",
    enabled = true,
    speed   = 4,
    bezier  = "fadeFast",
})

hl.animation({
    leaf    = "fadeOut",
    enabled = true,
    speed   = 3,
    bezier  = "fadeFast",
})


-- Layer surfaces:
-- Waybar, Rofi, SwayNC and similar Wayland layers.

hl.animation({
    leaf    = "layers",
    enabled = true,
    speed   = 5,
    bezier  = "snappy",
})

hl.animation({
    leaf    = "layersIn",
    enabled = true,
    speed   = 5,
    bezier  = "snappy",
    style   = "fade",
})

hl.animation({
    leaf    = "layersOut",
    enabled = true,
    speed   = 4,
    bezier  = "fadeFast",
    style   = "fade",
})


-- Workspaces

hl.animation({
    leaf    = "workspaces",
    enabled = true,
    speed   = 5,
    bezier  = "smooth",
    style   = "slide",
})

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout = "de",

        follow_mouse = 1,
        sensitivity  = 0,

        touchpad = {
            natural_scroll = true,
        },
    },
})

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})


---------------------
---- APPLICATIONS ---
---------------------

-- Terminal
hl.bind(
    mainMod .. " + Q",
    hl.dsp.exec_cmd(terminal)
)

-- Application launcher
hl.bind(
    mainMod .. " + SPACE",
    hl.dsp.exec_cmd("rofi -show drun")
)

-- Qutebrowser
hl.bind(
    mainMod .. " + B",
    hl.dsp.exec_cmd("qutebrowser")
)


-- File browser
hl.bind(
    mainMod .. " + F",
    hl.dsp.exec_cmd("rofi -show filebrowser")
)

-- Development
hl.bind(
    mainMod .. " + D",
    hl.dsp.exec_cmd("project-picker")
)

-- German lookup
hl.bind(
    mainMod .. " + G",
    hl.dsp.exec_cmd("german-lookup")
)
----------------------
---- WINDOW ACTIONS ---
----------------------

-- Close active window
hl.bind(
    mainMod .. " + C",
    hl.dsp.window.close()
)

-- Toggle floating
hl.bind(
    mainMod .. " + V",
    hl.dsp.window.float({ action = "toggle" })
)

-- Pseudo-tile
hl.bind(
    mainMod .. " + P",
    hl.dsp.window.pseudo()
)

-- Toggle dwindle split
hl.bind(
    mainMod .. " + J",
    hl.dsp.layout("togglesplit")
)


---------------------
---- FOCUS / MOVE ---
---------------------

hl.bind(
    mainMod .. " + left",
    hl.dsp.focus({ direction = "left" })
)

hl.bind(
    mainMod .. " + right",
    hl.dsp.focus({ direction = "right" })
)

hl.bind(
    mainMod .. " + up",
    hl.dsp.focus({ direction = "up" })
)

hl.bind(
    mainMod .. " + down",
    hl.dsp.focus({ direction = "down" })
)


-- Move focused window within the current workspace
hl.bind(
    mainMod .. " + SHIFT + left",
    hl.dsp.window.move({ direction = "left" })
)

hl.bind(
    mainMod .. " + SHIFT + right",
    hl.dsp.window.move({ direction = "right" })
)

hl.bind(
    mainMod .. " + SHIFT + up",
    hl.dsp.window.move({ direction = "up" })
)

hl.bind(
    mainMod .. " + SHIFT + down",
    hl.dsp.window.move({ direction = "down" })
)

--------------------
---- WORKSPACES ----
--------------------

for i = 1, 10 do
    local key = i % 10

    hl.bind(
        mainMod .. " + " .. key,
        hl.dsp.focus({ workspace = i })
    )

    hl.bind(
        mainMod .. " + SHIFT + " .. key,
        hl.dsp.window.move({ workspace = i })
    )
end

hl.bind(
    mainMod .. " + mouse_down",
    hl.dsp.focus({ workspace = "e+1" })
)

hl.bind(
    mainMod .. " + mouse_up",
    hl.dsp.focus({ workspace = "e-1" })
)


-------------------------
---- MOUSE MANAGEMENT ---
-------------------------

hl.bind(
    mainMod .. " + mouse:272",
    hl.dsp.window.drag(),
    { mouse = true }
)

hl.bind(
    mainMod .. " + mouse:273",
    hl.dsp.window.resize(),
    { mouse = true }
)


---------------------
---- SCREENSHOTS ----
---------------------

hl.bind(
    "Print",
    hl.dsp.exec_cmd("screenshot-full"),
    { release = true }
)

hl.bind(
    mainMod .. " + SHIFT + S",
    hl.dsp.exec_cmd("screenshot-region"),
    { release = true }
)

hl.bind(
    mainMod .. " + SHIFT + C",
    hl.dsp.exec_cmd("screenshot-clipboard"),
    { release = true }
)


-------------------
---- UTILITIES ----
-------------------

-- Lock
hl.bind(
    mainMod .. " + L",
    hl.dsp.exec_cmd("hyprlock")
)

-- Notifications
hl.bind(
    mainMod .. " + N",
    hl.dsp.exec_cmd("swaync-client -t")
)

-- Clipboard history
hl.bind(
    mainMod .. " + Y",
    hl.dsp.exec_cmd("clipboard-picker")
)

-- Power menu
hl.bind(
    mainMod .. " + SHIFT + P",
    hl.dsp.exec_cmd("power-menu")
)


------------------------
---- MEDIA / HARDWARE ---
------------------------

hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("volume-up"),
    { locked = true, repeating = true }
)

hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("volume-down"),
    { locked = true, repeating = true }
)

hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("volume-mute"),
    { locked = true }
)

hl.bind(
    "XF86MonBrightnessUp",
    hl.dsp.exec_cmd("brightness-up"),
    { locked = true, repeating = true }
)

hl.bind(
    "XF86MonBrightnessDown",
    hl.dsp.exec_cmd("brightness-down"),
    { locked = true, repeating = true }
)

hl.bind(
    mainMod .. " + E",
    hl.dsp.exec_cmd("thunar-clean")
)


----------------------------
---- WINDOW RULES ----------
----------------------------

hl.window_rule({
    name  = "suppress-maximize-events",
    match = {
        class = ".*",
    },

    suppress_event = "maximize",
})

hl.window_rule({
    name = "fix-xwayland-drags",

    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})
