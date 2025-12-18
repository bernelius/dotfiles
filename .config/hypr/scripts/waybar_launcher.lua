#!/usr/bin/env lua

--- Checks if the saved pid exists.
--- if no argument passed, checks if any waybar exists
--- @param needle (number|string)?
--- @return (number|nil)
local function get_waybar_pid(needle)
    --if no needle specified, we just take the first result of pidof waybar
    needle = needle or "%d+"
    local match = nil
    local h = io.popen("pidof waybar")
    if h then
        local out = h:read("*a")
        h:close()
        match = tonumber(out:match(needle))
    end
    return match
end

HOME = os.getenv("HOME")
local state_file = HOME .. "/.local/state/hypr/waybar_state"
local f = io.open(state_file, "r")
local saved_pid = nil
if f then
    saved_pid = f:read("n")
    f:close()
end

local active_pid = get_waybar_pid(saved_pid)
if saved_pid and active_pid == saved_pid then
    os.execute("kill " .. saved_pid)
end

os.execute("waybar &")
local pid = get_waybar_pid()

f = io.open(state_file, "w")
if f then
    f:write(pid .. "\n" .. 1)
    f:close()
end
