{ ... }:

{
  programs.git = {
    enable = true;
    userName = "bernelius";
    userEmail = "bob@bernelius.com";
    extraConfig = {
      diff.tool = "nvimtool";
      "difftool \"nvimtool\"".cmd = ''nvim -d "$LOCAL" "$REMOTE"'';
      pull.rebase = true;
    };
  };
}
