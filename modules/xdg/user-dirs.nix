{ config, ... }:

{
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    download = "${config.home.homeDirectory}/downloads";
    desktop = "${config.home.homeDirectory}/.local/share/applications";
    templates = "${config.home.homeDirectory}/docs";
    publicShare = "${config.home.homeDirectory}/docs";
    documents = "${config.home.homeDirectory}/docs";
    music = "${config.home.homeDirectory}/docs";
    pictures = "${config.home.homeDirectory}/docs/img";
    videos = "${config.home.homeDirectory}/docs";
  };
}
