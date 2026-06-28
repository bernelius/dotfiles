{ config, pkgs, lib, user, ... }:

{
  home.username = user;
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "26.05";

  nixpkgs.config.allowUnfree = true;

  imports = [
    ./modules/shell
    ./modules/term
    ./modules/dev
    ./modules/wm
    ./modules/hypr
    ./modules/nvim
    ./modules/services
    ./modules/xdg
  ];

  home.packages = with pkgs; [
    # Core utilities
    eza
    fzf
    zoxide
    direnv
    starship
    sesh
    fastfetch
    bat
    yazi

    # System utilities
    cliphist
    wl-clipboard
    brightnessctl
    grimblast
    hyprpicker
    playerctl
    btop
    bluetui

    # Applications
    firefox
    mpv

    # Custom / no HM module
    kanata
    tailscale

    # Fun
    figlet
    lolcat
  ];

  home.file.".XCompose".source = ./config/XCompose;

  programs.home-manager.enable = true;
}
