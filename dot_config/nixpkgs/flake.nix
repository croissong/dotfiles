# https://nix-community.github.io/home-manager/index.html#ch-nix-flakes
{
  description = "Home Manager configuration of moi";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    # TODO: https://github.com/nix-community/home-manager/issues/2942
    allowUnfree = true;
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    homeConfigurations.moi = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./home.nix
      ];
    };
  };
}
