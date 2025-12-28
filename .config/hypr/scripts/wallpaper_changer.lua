#!/usr/bin/env lua

local wallpapers = {
    multi = "~/docs/img/wallpapers/multiman.png",
    smooshy = "~/docs/img/wallpapers/smooshy_king.png",
    black = "~/docs/img/wallpapers/black_pixels.png",
    cleese = "~/docs/img/wallpapers/soviet_cleese.png",
}

local workspace_papers = {
    [1] = wallpapers.multi,
    [2] = wallpapers.multi,
    [3] = wallpapers.multi,
    [4] = wallpapers.multi,
    [5] = wallpapers.multi,
    [6] = wallpapers.smooshy,
    [7] = wallpapers.black,
}

local get_active_workspace = function()
    local h = io.popen("hyprctl activeworkspace -j", "r")
    if h then
        local _ = h:read("l")
        local workspace_id = h:read("l"):match("%d+")
        h:close()
        return workspace_id
    end
end

local choice = "set"
local actions = {
    set = "workspace",
    move = "movetoworkspace",
}

local workspace_dest = tonumber(arg[1])
assert(
    workspace_dest and workspace_dest >= 1,
    "Invalid workspace. This script takes a workspace number, and optionally set|move. In that order."
)
if arg[2] then
    choice = arg[2]
    local valid_actions = { set = true, move = true }
    if not valid_actions[choice] then
        error("Invalid action. This script takes a workspace number, and optionally set|move. In that order.")
    end
end

local action = actions[choice]

local active_workspace = get_active_workspace()
if workspace_dest ~= active_workspace then
    os.execute("hyprctl dispatch " .. action .. " " .. workspace_dest)
    local old_workspace = active_workspace
    active_workspace = workspace_dest
    local new_wallpaper = workspace_papers[workspace_dest]
    if new_wallpaper and new_wallpaper ~= workspace_papers[old_workspace] then
        os.execute("hyprctl hyprpaper wallpaper 'eDP-1, " .. workspace_papers[workspace_dest] .. "'")
    else
        os.execute(
            "notify-send 'No wallpaper found for workspace "
                .. workspace_dest
                .. ". This workspace does not have a wallpaper set in wallpaper_changer.lua.'"
        )
    end

    -- sometimes hyprpaper crashes when switching workspaces too fast
    os.execute("pidof hyprpaper || hyprpaper &")
end
