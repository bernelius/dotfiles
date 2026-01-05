local function capture_stdout(command)
    local handle, err = io.popen(command, "r")
    if handle == nil then
        os.execute('notify-send("Failed to run io.popen: "' .. err .. "'")
        os.exit(1)
    end
    local stdout = handle:read("*a")
    handle:close()
    return stdout
end

---@diagnostic disable-next-line: unused-local
local function hide_youtube_webapp(event)
    os.execute("hyprctl dispatch layoutmsg preselect u")
    local current_window_pid = capture_stdout("hyprctl activewindow | grep pid | sed 's/[[:space:]]//g'")

    os.execute("hyprctl dispatch focuswindow class:^WebApp-YouTube.*")
    -- the -A 5 -B 5 are arbitrary. At the moment the pid is 2 lines below initialClass, but this could change
    -- after sed is applied the string should be "pid:%d+" without spaces
    local youtube_window_pid = capture_stdout(
        'hyprctl clients | grep "initialClass: WebApp-YouTube" -A 8 -B 8 -m 1 | grep pid | sed "s/[[:space:]]//g"'
    )

    os.execute("hyprctl keyword 'windowrule[youtubedl-workspace-4]:no_focus on'")
    mp.disable_key_bindings("default")
    --os.execute("notify-send '" .. youtube_window_pid .. "'")
    mp.add_timeout(0.05, function()
        os.execute("notify-send 'we playin'")
        mp.set_property(
            "title",
            -- YouTubeDL: + the default title + - mpv
            "YouTubeDL: ${!playlist-count==1:[${playlist-pos-1}/${playlist-count}] }${media-title} - mpv"
        )
        os.execute("hyprctl dispatch movetoworkspacesilent special:hidden," .. youtube_window_pid)
        if current_window_pid ~= youtube_window_pid then
            os.execute("hyprctl dispatch focuswindow " .. current_window_pid)
        end
    end)
    mp.add_timeout(0.5, function()
        os.execute("hyprctl keyword 'windowrule[youtubedl-workspace-4]:no_focus off'")
        mp.enable_key_bindings("default")
    end)
end

---@diagnostic disable-next-line: unused-local
local function unhide_youtube_webapp(event)
    os.execute("notify-send 'we quittin'")
    os.execute("~/.config/hypr/scripts/dispatchers/hypr_next_window_up.sh")
    os.execute('hyprctl dispatch movetoworkspacesilent 4,class:"^WebApp-YouTube.*"')
end

mp.register_event("file-loaded", hide_youtube_webapp)
mp.register_event("end-file", unhide_youtube_webapp)
