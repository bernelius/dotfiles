{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    hyprpolkitagent
    swayosd
    grimblast
  ];

  xdg.configFile."hypr/hyprland.lua".source = ../../config/hypr/hyprland.lua;
  xdg.configFile."hypr/.luarc.json".source = ../../config/hypr/.luarc.json;
  xdg.configFile."hypr/scripts" = {
    source = ../../config/hypr/scripts;
    recursive = true;
  };
  xdg.configFile."hypr/themes/mocha.conf".source = ../../config/hypr/themes/mocha.conf;
  xdg.configFile."hypr/themes/mocha.lua".source = ../../config/hypr/themes/mocha.lua;
  xdg.configFile."hypr/hosts" = {
    source = ../../hosts;
    recursive = true;
  };
}
