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
    -- kill any running waybars before launching
    os.execute("killall waybar 2>/dev/null")

    os.execute("waybar &")
    state.waybar_pid = pidof("waybar")
    state.waybar_visible = true
end

function M.get_pid()
    return state.waybar_pid
end

return M
