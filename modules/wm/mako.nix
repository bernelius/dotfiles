{ ... }:

{
  services.mako = {
    enable = true;
    settings = {
      font = "JetBrainsMonoNL Nerd Font Mono (monospace)";
      background-color = "#121212";
      width = 350;
      height = 200;
      border-color = "#cdd6f4";
      progress-color = "#a6e3a1";
      text-color = "#cdd6f4";
      default-timeout = 5000;
      anchor = "top-right";
    };

    extraConfig = ''
      [urgency=low]
      border-color=#cdd6f4
      progress-color=#a6e3a1

      [urgency=normal]
      border-color=#fab387
      progress-color=#fab387

      [urgency=high]
      border-color=#f38ba8
      progress-color=#f38ba8
    '';
  };

  xdg.configFile."mako/default_action.sh" = {
    source = ../../config/mako/default_action.sh;
    executable = true;
  };
}
