local M = {}

local state = require("scripts.state")

local function pidof(name)
    local h = io.popen("pidof " .. name)
    if h then
        local out = h:read("*a")
        h:close()
        return tonumber(out:match("%d+"))
    end
    return nil
end

function M.launch()
    -- restart via systemd user service so crash recovery is handled automatically
    os.execute("systemctl --user restart waybar")
    state.waybar_pid = pidof("waybar")
    state.waybar_visible = true
end

function M.stop()
    os.execute("systemctl --user stop waybar")
    state.waybar_pid = nil
    state.waybar_visible = false
end

function M.get_pid()
    return state.waybar_pid
end

return M
