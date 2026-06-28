{ ... }:

{
  programs.hyprlock = {
    enable = true;
    package = null;

    settings = {
      source = "~/.config/hypr/themes/mocha.conf";

      general = {
        hide_cursor = true;
        grace = 0;
        disable_loading_bar = true;
      };

      animation = [
        { name = "global"; value = 0; }
      ];

      background = [
        {
          monitor = "";
          blur_passes = 1;
          contrast = 1;
          brightness = 0.2;
          vibrancy = 0;
          vibrancy_darkness = 1;
        }
      ];

      "input-field" = [
        {
          monitor = "";
          size = "20%, 5%";
          outline_thickness = 15;
          dots_size = 0.2;
          dots_spacing = 0.35;
          dots_center = true;
          dots_rounding = 1;
          outer_color = "rgb(0, 0, 0)";
          inner_color = "$mantle";
          font_color = "$text";
          fade_on_empty = true;
          fade_timeout = 2000;
          rounding = 1;
          check_color = "$yellow";
          fail_color = "$red";
          placeholder_text = "";
          font_family = "aldrich";
          fail_text = "<b>attempts: $ATTEMPTS/3</b>";
          hide_input = false;
          position = "0, 0";
          halign = "center";
          valign = "center";
          zindex = 2;
        }
      ];

      label = [
        {
          monitor = "";
          text = "$USER";
          color = "$text";
          font_size = 30;
          font_family = "aldrich";
          position = "0, 0";
          halign = "center";
          valign = "center";
          zindex = 1;
        }
        {
          monitor = "";
          text = "$TIME";
          color = "$overlay1";
          font_size = 30;
          font_family = "aldrich";
          position = "0, 100";
          halign = "center";
          valign = "center";
          zindex = 1;
        }
      ];
    };
  };
}
