{ ... }:

{
  programs.yazi = {
    enable = true;
    settings = {
      mgr.show_hidden = true;
    };
  };

  xdg.configFile."yazi/theme.toml".source = ../../config/yazi/theme.toml;
  xdg.configFile."yazi/catppuccin-mocha.tmTheme".source = ../../config/yazi/catppuccin-mocha.tmTheme;
}
