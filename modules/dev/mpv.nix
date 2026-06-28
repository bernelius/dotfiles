{ ... }:

{
  programs.mpv = {
    enable = true;
    config = {
      hwdec = "auto";
      "target-colorspace-hint" = false;
      "ytdl-raw-options" = "cookies-from-browser=firefox";
    };
    profiles = {
      "protocol.https" = {
        speed = 1;
      };
      "protocol.http" = {
        profile = "protocol.https";
      };
    };
  };
}
