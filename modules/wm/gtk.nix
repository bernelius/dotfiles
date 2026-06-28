{ config, ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-mocha-red-standard+default";
      package = null;
    };
    iconTheme = {
      name = "Adwaita";
      package = null;
    };
    font = {
      name = "Adwaita Sans";
      size = 11;
      package = null;
    };
    cursorTheme = {
      name = "Adwaita";
      package = null;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
      gtk-cursor-theme-size = 24;
      gtk-toolbar-style = "GTK_TOOLBAR_BOTH_HORIZ";
      gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";
      gtk-button-images = 0;
      gtk-menu-images = 0;
      gtk-enable-event-sounds = 1;
      gtk-enable-input-feedback-sounds = 0;
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "none";
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
