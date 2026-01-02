local function remove_focus_from_youtube_webapp(event)
    os.execute("~/.config/hypr/scripts/dispatchers/hypr_next_window_up.sh")
    os.execute("notify-send 'we playin'")
    mp.set_property(
        "title",
        "YouTubeDL: ${!playlist-count==1:[${playlist-pos-1}/${playlist-count}] }${media-title} - mpv"
    )
    os.execute('hyprctl dispatch movetoworkspacesilent special:hidden,class:"^WebApp-YouTube.*"')
    --in case we spawn in the wrong place
    --os.execute("hyprctl keyword 'windowrule[monkeytype-workspace-4]:no_focus on'")
    --os.execute("hyprctl dispatch moveintogroup u")
    --os.execute("hyprctl keyword 'windowrule[monkeytype-workspace-4]:no_focus off'")
end

local function grant_focus_to_youtube_webapp(event)
    os.execute("notify-send 'we quittin'")
    os.execute("~/.config/hypr/scripts/dispatchers/hypr_next_window_up.sh")
    os.execute('hyprctl dispatch movetoworkspacesilent 4,class:"^WebApp-YouTube.*"')
    --os.execute("hyprctl keyword 'windowrule[youtube-app-workspace-4-opaque]:no_focus off'")
end

mp.register_event("file-loaded", remove_focus_from_youtube_webapp)
mp.register_event("end-file", grant_focus_to_youtube_webapp)
