{ ... }:

{
  programs.bat = {
    enable = true;
    config.theme = "Catppuccin Mocha";
  };

  xdg.configFile."bat/themes/Catppuccin-mocha.tmTheme".source = ../../config/bat/Catppuccin-mocha.tmTheme;
}
