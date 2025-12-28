#!/usr/bin/env lua

HOME = os.getenv("HOME")
GAP_STATE_FILE = HOME .. "/.local/state/hypr/hypr_gap_state"
WAYBAR_STATE_FILE = HOME .. "/.local/state/hypr/waybar_state"
-- modify this to change the outer gap size
MAX_GAP_SIZE = 5

local function read_hypr_gap_size()
    local gap_size = MAX_GAP_SIZE
    local f = io.open(GAP_STATE_FILE, "r")
    if f then
        local val = f:read("*n")
        if val then
            gap_size = val
        end
        f:close()
    else
        os.execute("mkdir -p " .. HOME .. "/.local/state/hypr")
        print("mkdir -p " .. HOME .. "/.local/state/hypr")
    end
    return gap_size
end

local function main()
    local gap_size = read_hypr_gap_size()

    local waybar_pid = nil
    local waybar_state = nil

    local f = io.open(WAYBAR_STATE_FILE, "r")
    if f then
        waybar_pid = f:read("n")
        waybar_state = f:read("n")
        f:close()
    end

    if not waybar_pid or not waybar_state then
        print("The waybar state file is bad. Killing all waybars and relaunching with waybar_launcher.")
        os.execute("killall waybar")

        require("waybar_launcher")
        return 1
    end

    if waybar_state == 1 then
        waybar_state = 0
    else
        waybar_state = 1
    end

    os.execute("kill -s USR1 " .. waybar_pid)

    f = io.open(WAYBAR_STATE_FILE, "w")
    if f then
        f:write(waybar_pid .. "\n" .. waybar_state)
        f:close()
    end

    if gap_size > 0 then
        gap_size = 0
    else
        gap_size = MAX_GAP_SIZE
    end

    if gap_size == 0 and waybar_state ~= 0 or waybar_state == 0 and gap_size ~= 0 then
        -- if we are here it means the two states are out of sync
        print("gap size is ", gap_size, "waybar state is ", waybar_state)
        return 2
    end

    -- apply
    os.execute("hyprctl keyword general:gaps_out " .. gap_size)

    -- save new state
    f = io.open(GAP_STATE_FILE, "w")
    if f then
        f:write(gap_size)
        f:close()
    end
end

main()
