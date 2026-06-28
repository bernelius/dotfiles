{ pkgs, ... }:

{
  systemd.user.services.waybar = {
    Unit = {
      Description = "Highly customizable Wayland bar for Sway and Wlroots based compositors";
      Documentation = "https://github.com/Alexays/Waybar/wiki";
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.waybar}/bin/waybar";
      Restart = "on-failure";
      RestartSec = "1";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  xdg.configFile."systemd/user/graphical-session.target.d/override.conf".text = ''
    [Unit]
    RefuseManualStart=no
    StopWhenUnneeded=no
  '';
}
