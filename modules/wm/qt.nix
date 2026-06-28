{ pkgs, ... }:

{
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  qt.kvantum = {
    enable = true;
    settings = {
      General = {
        theme = "catppuccin-mocha-red";
      };
    };
    themes = with pkgs; [
      (catppuccin-kvantum.override {
        variant = "mocha";
        accent = "red";
      })
    ];
  };
}
