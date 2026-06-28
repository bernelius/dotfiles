{ ... }:

{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "JetBrainsMonoNL Nerd Font Propo:size=16";
        icon-theme = "Breeze Chameleon Dark";
        terminal = "alacritty --class=fuzzel -e";
        width = 50;
        "keyboard-focus" = "exclusive";
        "exit-on-keyboard-focus-loss" = "yes";
      };
      colors = {
        background = "1e1e2eff";
        text = "cdd6f4ff";
        prompt = "586e75ff";
        input = "cdd6f4ff";
        match = "fab387ff";
        selection = "000000ff";
        "selection-text" = "cdd6f4ff";
        "selection-match" = "fab387ff";
        border = "45475aff";
      };
      border = {
        width = 10;
        radius = 0;
      };
    };
  };
}
