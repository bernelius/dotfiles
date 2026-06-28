local M = {}

local state = require("scripts.state")
local waybar_launcher = require("scripts.waybar_launcher")

local function is_waybar_active()
    local h = io.popen("systemctl --user is-active waybar")
    if h then
        local out = h:read("*a")
        h:close()
        return out:match("active") ~= nil
    end
    return false
end

function M.toggle()
    hl.notification.get()
    -- health check: if waybar is missing, relaunch it and reset to defaults
    if not is_waybar_active() then
        waybar_launcher.launch()
        state.gap_size = state.max_gap_size
        state.waybar_visible = true
        hl.config({ general = { gaps_out = state.gap_size } })
        return
    end

    -- toggle gap and waybar visibility in lockstep
    if state.gap_size > 0 then
        state.gap_size = 0
        state.waybar_visible = false
    else
        state.gap_size = state.max_gap_size
        state.waybar_visible = true
    end

    -- apply gap using the Hyprland Lua API
    hl.config({ general = { gaps_out = state.gap_size } })

    -- toggle waybar visibility via SIGUSR1 via systemd (always targets live process)
    os.execute("systemctl --user kill -s USR1 waybar")
end

return M
