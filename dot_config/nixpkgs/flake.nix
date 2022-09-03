# https://nix-community.github.io/home-manager/index.html#ch-nix-flakes
# TODO: https://www.reddit.com/r/NixOS/comments/qpqnfq/flake_structure_for_multi_system/hjx1hr0/?context=3
{
  description = "Home Manager configuration of moi";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = {
    nixpkgs,
    home-manager,
    rust-overlay,
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
      extraSpecialArgs = {
        inherit rust-overlay;
      };
    };
  };
}
