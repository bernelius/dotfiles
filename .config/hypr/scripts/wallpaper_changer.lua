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

local last_workspace = nil

local msg = "Invalid input. This function takes a workspace number above 0, and optionally set|move. In that order."

local function change_workspace(workspace_dest, choice)
    choice = choice or "set"

    local actions = {
        set = function(dest)
            hl.dispatch(hl.dsp.focus({ workspace = dest }))
        end,
        move = function(dest)
            hl.dispatch(hl.dsp.window.move({ workspace = dest, follow = true }))
        end,
    }

    assert(workspace_dest and workspace_dest > 0, msg)
    assert(actions[choice], msg)

    actions[choice](workspace_dest)

    local new_wallpaper = workspace_papers[workspace_dest]
    if new_wallpaper then
        if new_wallpaper ~= workspace_papers[last_workspace] then
            hl.exec_cmd(string.format("hyprctl hyprpaper wallpaper ',%s,%s'", new_wallpaper.path, new_wallpaper.fit_mode))
        end
    else
        hl.exec_cmd(
            "notify-send 'No wallpaper found for workspace "
                .. workspace_dest
                .. ". This workspace does not have a wallpaper set in wallpaper_changer.lua.'"
        )
    end
    -- sometimes hyprpaper crashes when switching workspaces too fast
    hl.exec_cmd("(pidof hyprpaper >/dev/null || (hyprpaper &))")

    last_workspace = workspace_dest
end

return change_workspace
