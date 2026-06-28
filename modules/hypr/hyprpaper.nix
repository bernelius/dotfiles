{ ... }:

{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "~/docs/img/wallpapers/multiman.png"
        "~/docs/img/wallpapers/smooshy_king.png"
        "~/docs/img/wallpapers/black_pixels.png"
        "~/docs/img/wallpapers/soviet_cleese.png"
      ];
      wallpaper = [
        {
          monitor = "";
          path = "~/docs/img/wallpapers/multiman.png";
          fit_mode = "cover";
        }
      ];
      splash = false;
      ipc = true;
    };
  };
}
