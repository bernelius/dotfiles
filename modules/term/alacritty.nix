{ config, pkgs, lib, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "JetBrains Mono Nerd Font Mono";
          style = "Regular";
        };
        size = 12.0;
      };
      general = {
        import = [
          "${config.xdg.configHome}/alacritty/catppuccin-mocha.toml"
        ];
      };
      env.TERM = "xterm-256color";
    };
  };

  xdg.configFile."alacritty/catppuccin-mocha.toml".source = ../../config/alacritty/catppuccin-mocha.toml;
}
