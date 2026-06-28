{ ... }:

{
  services.mako = {
    enable = true;
    font = "JetBrainsMonoNL Nerd Font Mono (monospace)";
    backgroundColor = "#121212";
    width = 350;
    height = 200;
    borderColor = "#cdd6f4";
    progressColor = "#a6e3a1";
    textColor = "#cdd6f4";
    defaultTimeout = 5000;
    anchor = "top-right";

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
