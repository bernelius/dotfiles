{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "bernelius";
      user.email = "bob@bernelius.com";
      diff.tool = "nvimtool";
      "difftool \"nvimtool\"".cmd = ''nvim -d "$LOCAL" "$REMOTE"'';
      pull.rebase = true;
    };
  };
}
