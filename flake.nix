{
  description = "bernelius dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      mkHome = { host, user ? "bernelius", system ? "x86_64-linux" }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = { inherit host user inputs; };
          modules = [
            ./home.nix
            ./hosts/${host}/home.nix
          ];
        };
    in
    {
      homeConfigurations = {
        "bernelius@tuxedo" = mkHome { host = "tuxedo"; };
      };
    };
}
