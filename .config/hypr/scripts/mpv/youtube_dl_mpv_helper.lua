local function remove_focus_from_youtube_webapp(event)
    os.execute("notify-send 'we playin'")
    mp.set_property(
        "title",
        "YouTubeDL: ${!playlist-count==1:[${playlist-pos-1}/${playlist-count}] }${media-title} - mpv"
    )
    os.execute("hyprctl keyword 'windowrule[youtube-app-workspace-4-opaque]:no_focus on'")
end

local function grant_focus_to_youtube_webapp(event)
    os.execute("notify-send 'we quittin'")
    if event.reason == "quit" then
        os.execute("hyprctl keyword 'windowrule[youtube-app-workspace-4-opaque]:no_focus off'")
    end
end

mp.register_event("file-loaded", remove_focus_from_youtube_webapp)
mp.register_event("end-file", grant_focus_to_youtube_webapp)
