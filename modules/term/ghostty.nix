{ ... }:

{
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "catppuccin-mocha";
      "font-family" = "JetBrainsMono Nerd Font Mono";
      "font-size" = 12;
      "gtk-titlebar" = false;
    };
  };

  xdg.configFile."ghostty/themes" = {
    source = ../../config/ghostty/themes;
    recursive = true;
  };
}
