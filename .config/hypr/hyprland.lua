-- Hyprland Lua configuration
-- Converted from hyprland.conf for Hyprland 0.55+
-- https://wiki.hypr.land/Configuring/Start/

-- Load color theme
local c = require("themes.mocha")
local rosewater = c.rosewater
local flamingo = c.flamingo
local pink = c.pink
local mauve = c.mauve
local red = c.red
local maroon = c.maroon
local peach = c.peach
local yellow = c.yellow
local green = c.green
local teal = c.teal
local sky = c.sky
local sapphire = c.sapphire
local blue = c.blue
local lavender = c.lavender
local text = c.text
local subtext1 = c.subtext1
local subtext0 = c.subtext0
local overlay2 = c.overlay2
local overlay1 = c.overlay1
local overlay0 = c.overlay0
local surface2 = c.surface2
local surface1 = c.surface1
local surface0 = c.surface0
local base = c.base
local mantle = c.mantle
local crust = c.crust

local wallpaper_changer = require("scripts.wallpaper_changer")
local toggle_gap_size = require("scripts.toggle_gap_size")
local waybar_launcher = require("scripts.waybar_launcher")

local function wp(n, action)
    return function()
        wallpaper_changer(n, action)
    end
end

------------------
---- MONITORS ----
------------------

hl.monitor({
    output = "eDP-1",
    mode = "2560x1600@240",
    position = "0x0",
    scale = "1.6",
})

hl.monitor({
    output = "HDMI-A-1",
    mode = "preferred",
    position = "auto",
    scale = "auto",
})

---------------------
---- MY PROGRAMS ----
---------------------

local terminal = "ghostty"
local menu = "fuzzel"
local browser = "firefox"

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("hypridle")
    waybar_launcher.launch()
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("swayosd-server")
    hl.exec_cmd("tuxedo-control-center --tray")
    hl.exec_cmd("surfshark")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("GDK_SCALE", "2")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPR_OUTER_GAP_SIZE", "5")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("XDG_MENU_PREFIX", "arch-")
hl.env("GTK_THEME", "catppuccin-mocha-red-standard+default")
hl.env("GTK_IM_MODULE", "simple")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in = -1,
        gaps_out = 5,

        border_size = 2,

        col = {
            active_border = overlay0,
            inactive_border = mantle,
        },

        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding = 0,
        rounding_power = 2,

        active_opacity = 1.0,
        inactive_opacity = 0.93,

        shadow = {
            enabled = false,
        },

        blur = {
            enabled = false,
        },
    },

    animations = {
        enabled = false,
    },

    dwindle = {
        force_split = 2,
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = 1,
        disable_hyprland_logo = true,
        size_limits_tiled = true,
    },

    xwayland = {
        force_zero_scaling = true,
    },

    group = {
        col = {
            border_active = overlay0,
        },
    },
})

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout = "us",
        kb_options = "compose:ralt",
        kb_variant = "",
        kb_rules = "",

        follow_mouse = 1,
        sensitivity = 0,

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

--------------------
---- KEYBINDINGS ----
--------------------

local mainMod = "SUPER"

-- Basic binds
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + ALT + CTRL + Q", hl.dsp.exit())
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SHIFT + ALT + CTRL + C", hl.dsp.exec_cmd("hyprpicker --autocopy --format=hex"))
hl.bind(mainMod .. " + ALT + M", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + ALT + P", hl.dsp.exec_cmd("cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + ALT + F", toggle_gap_size.toggle)
hl.bind(mainMod .. " + ALT + SHIFT + CTRL + L", hl.dsp.exec_cmd("loginctl lock-session"))
hl.bind(mainMod .. " + ALT + S", hl.dsp.exec_cmd("grimblast copy area --freeze"))
hl.bind(
    mainMod .. " + CTRL + ALT + SHIFT + S",
    hl.dsp.exec_cmd('GRIMBLAST_EDITOR="satty --early-exit --copy-command=wl-copy --filename" grimblast edit output')
)

-- Move focus (arrow keys)
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Move focus (vim keys)
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Workspace switching (letter keys + wallpaper)
hl.bind(mainMod .. " + W", wp(1))
hl.bind(mainMod .. " + D", wp(2))
hl.bind(mainMod .. " + N", wp(3))
hl.bind(mainMod .. " + T", wp(4))
hl.bind(mainMod .. " + P", wp(5))
hl.bind(mainMod .. " + G", wp(6))
hl.bind(mainMod .. " + V", wp(7))

-- Toggle special workspace
hl.bind(mainMod .. " + SHIFT + ALT + CTRL + H", hl.dsp.workspace.toggle_special("hidden"))

-- Workspace switching (number keys + wallpaper)
hl.bind(mainMod .. " + 1", wp(1))
hl.bind(mainMod .. " + 2", wp(2))
hl.bind(mainMod .. " + 3", wp(3))
hl.bind(mainMod .. " + 4", wp(4))
hl.bind(mainMod .. " + 5", wp(5))
hl.bind(mainMod .. " + 6", wp(6))
hl.bind(mainMod .. " + 7", wp(7))

-- Resize active window
hl.bind(mainMod .. " + ALT + H", hl.dsp.window.resize({ x = -30, y = 0 }))
hl.bind(mainMod .. " + ALT + J", hl.dsp.window.resize({ x = 0, y = 30 }))
hl.bind(mainMod .. " + ALT + K", hl.dsp.window.resize({ x = 0, y = -30 }))
hl.bind(mainMod .. " + ALT + L", hl.dsp.window.resize({ x = 30, y = 0 }))

-- Move window directionally
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

-- Move active window to workspace (letter keys)
hl.bind(mainMod .. " + SHIFT + W", wp(1, "move"))
hl.bind(mainMod .. " + SHIFT + D", wp(2, "move"))
hl.bind(mainMod .. " + SHIFT + N", wp(3, "move"))
hl.bind(mainMod .. " + SHIFT + T", wp(4, "move"))
hl.bind(mainMod .. " + SHIFT + P", wp(5, "move"))
hl.bind(mainMod .. " + SHIFT + G", wp(6, "move"))
hl.bind(mainMod .. " + SHIFT + V", wp(7, "move"))
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.window.move({ workspace = "special:hidden" }))

-- Move active window to workspace (number keys)
hl.bind(mainMod .. " + SHIFT + 1", wp(1, "move"))
hl.bind(mainMod .. " + SHIFT + 2", wp(2, "move"))
hl.bind(mainMod .. " + SHIFT + 3", wp(3, "move"))
hl.bind(mainMod .. " + SHIFT + 4", wp(4, "move"))
hl.bind(mainMod .. " + SHIFT + 5", wp(5, "move"))
hl.bind(mainMod .. " + SHIFT + 6", wp(6, "move"))
hl.bind(mainMod .. " + SHIFT + 7", wp(7, "move"))

-- Scroll through workspaces
hl.bind(mainMod .. " + Tab", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + ALT + Tab", hl.dsp.focus({ workspace = "e-1" }))

-- Mouse binds
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys (locked + repeating)
hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("swayosd-client --output-volume raise"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("swayosd-client --output-volume lower"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioMicMute",
    hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86MonBrightnessUp",
    hl.dsp.exec_cmd("swayosd-client --brightness raise"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86MonBrightnessDown",
    hl.dsp.exec_cmd("swayosd-client --brightness lower"),
    { locked = true, repeating = true }
)

-- Media transport keys (locked)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next && swayosd-client --playerctl next"), { locked = true })
hl.bind(
    "XF86AudioPause",
    hl.dsp.exec_cmd("playerctl play-pause && swayosd-client --playerctl play-pause"),
    { locked = true }
)
hl.bind(
    "XF86AudioPlay",
    hl.dsp.exec_cmd("playerctl play-pause && swayosd-client --playerctl play-pause"),
    { locked = true }
)
hl.bind(
    "XF86AudioPrev",
    hl.dsp.exec_cmd("playerctl previous && swayosd-client --playerctl previous"),
    { locked = true }
)

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- Workspace rules
hl.workspace_rule({ workspace = "1", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "2", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "3", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "4", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "5", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "6", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "7", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "special:hidden" })

-- Window rules
hl.window_rule({
    name = "ignore-maximize",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "inhibit-idle-on-fullscreen-focus",
    match = { focus = true, fullscreen = true },
    idle_inhibit = "always",
})

hl.window_rule({
    name = "obs-studio-to-hidden",
    match = { class = "com.obsproject.Studio" },
    workspace = "special:hidden",
})

hl.window_rule({
    name = "obs-studio-preview-to-7",
    match = { class = "com.obsproject.Studio", title = "^Projector.*" },
    workspace = 7,
    fullscreen = true,
})

hl.window_rule({
    name = "surfshark-to-hidden",
    match = { class = "^Surfshark$" },
    workspace = "special:hidden",
})

hl.window_rule({
    name = "qbittorrent-to-hidden",
    match = { class = ".*qBittorrent.*" },
    workspace = "special:hidden",
})

hl.window_rule({
    name = "float-fuzzel-launched-terminal-apps",
    match = { class = "^fuzzel$" },
    float = true,
    size = "(monitor_w*0.9) (monitor_h*0.8)",
    rounding = 5,
    border_size = 5,
    border_color = peach,
})

hl.window_rule({
    name = "mpv-opaque",
    match = { class = "^mpv$" },
    opaque = true,
})

hl.window_rule({
    name = "youtube-app-workspace-4-opaque",
    match = { class = "^WebApp-YouTube.*" },
    workspace = 4,
    opaque = true,
})

hl.window_rule({
    name = "monkeytype-workspace-4",
    match = { class = "^WebApp-Monkeytype.*" },
    workspace = 4,
})

hl.window_rule({
    name = "youtubedl-workspace-4",
    match = { class = "^mpv$", title = "^YouTubeDL.* - mpv$" },
    workspace = 4,
})
