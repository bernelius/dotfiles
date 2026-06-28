local M = {}

local state = require("scripts.state")

function M.launch()
    -- restart via systemd user service so crash recovery is handled automatically
    os.execute("systemctl --user restart waybar")
    state.waybar_visible = true
end

function M.stop()
    os.execute("systemctl --user stop waybar")
    state.waybar_visible = false
end

return M
