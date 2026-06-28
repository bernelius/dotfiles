{ ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-mocha-red-standard+default";
      package = null; # Managed via nix or manual install
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
}
