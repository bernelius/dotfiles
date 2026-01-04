local function capture_stdout(command)
    local handle = assert(io.popen(command, "r"))
    local stdout = assert(handle:read("*a"))
    handle:close()
    return stdout
end

---@diagnostic disable-next-line: unused-local
local function hide_youtube_webapp(event)
    os.execute("~/.config/hypr/scripts/dispatchers/hypr_next_window_up.sh")
    local current_window_pid = capture_stdout("hyprctl activewindow | grep pid"):gsub("%s+", "")

    os.execute("hyprctl dispatch focuswindow class:^WebApp-YouTube.*")
    local youtube_window_pid = capture_stdout("hyprctl activewindow | grep pid"):gsub("%s+", "")
    -- os.execute("notify-send '" .. youtube_window_pid .. "'")
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
end

---@diagnostic disable-next-line: unused-local
local function unhide_youtube_webapp(event)
    os.execute("notify-send 'we quittin'")
    os.execute("~/.config/hypr/scripts/dispatchers/hypr_next_window_up.sh")
    os.execute('hyprctl dispatch movetoworkspacesilent 4,class:"^WebApp-YouTube.*"')
end

mp.register_event("file-loaded", hide_youtube_webapp)
mp.register_event("end-file", unhide_youtube_webapp)
