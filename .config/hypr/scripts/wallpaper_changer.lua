#!/usr/bin/env lua

local wallpapers = {
    multi = { path = "~/docs/img/wallpapers/multiman.png", fit_mode = "cover" },
    smooshy = { path = "~/docs/img/wallpapers/smooshy_king.png", fit_mode = "cover" },
    black = { path = "~/docs/img/wallpapers/black_pixels.png", fit_mode = "tile" },
    cleese = { path = "~/docs/img/wallpapers/soviet_cleese.png", fit_mode = "cover" },
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
        return tonumber(workspace_id)
    end
end

local msg = "Invalid input. This script takes a workspace number above 0, and optionally set|move. In that order."
local actions = {
    set = "workspace",
    move = "movetoworkspace",
}
local choice = "set"

local workspace_dest = tonumber(arg[1])
assert(workspace_dest and workspace_dest > 0, msg)

if arg[2] then
    choice = arg[2]
end

assert(actions[choice], msg)

local action = actions[choice]

local active_workspace = get_active_workspace()
local shell_cmds = {}
if workspace_dest ~= active_workspace then
    table.insert(shell_cmds, string.format("hyprctl dispatch %s %d", action, workspace_dest))
    local old_workspace = active_workspace
    active_workspace = workspace_dest
    local new_wallpaper = workspace_papers[workspace_dest]
    if new_wallpaper then
        if new_wallpaper ~= workspace_papers[old_workspace] then
            table.insert(
                shell_cmds,
                string.format("hyprctl hyprpaper wallpaper ',%s,%s'", new_wallpaper.path, new_wallpaper.fit_mode)
            )
        end
    else
        os.execute(
            "notify-send 'No wallpaper found for workspace "
                .. workspace_dest
                .. ". This workspace does not have a wallpaper set in wallpaper_changer.lua.'"
        )
    end
    -- sometimes hyprpaper crashes when switching workspaces too fast
    local revival_command = "(pidof hyprpaper >/dev/null || (hyprpaper &))"
    table.insert(shell_cmds, revival_command)
    local final_batch = table.concat(shell_cmds, " && ")
    local final_command = string.format("( %s ) &", final_batch)
    print(final_command)
    os.execute(final_command)
end
