# https://nix-community.github.io/home-manager/index.html#ch-nix-flakes
# https://nix-community.github.io/home-manager/options.html
# TODO: https://www.reddit.com/r/NixOS/comments/qpqnfq/flake_structure_for_multi_system/hjx1hr0/?context=3
{
  description = "Home Manager configuration of moi";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixpkgs-prev.url = "github:nixos/nixpkgs/81e8f48ebdecf07aab321182011b067aafc78896";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-22.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay.url = "github:oxalica/rust-overlay";
    tree-grepper.url = "github:BrianHicks/tree-grepper";
    tree-grepper.inputs.nixpkgs.follows = "nixpkgs";
    nixgl.url = "github:guibou/nixGL";
    nixgl.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    nixpkgs-master,
    nixpkgs-prev,
    nixpkgs-stable,
    nixgl,
    home-manager,
    rust-overlay,
    tree-grepper,
    nur,
    ...
  }: let
    system = "x86_64-linux";

    overlays = import ./flake-overlays.nix;
    pkgs = import nixpkgs {
      inherit system;
      overlays = overlays;
    };
    pkgs-stable = nixpkgs-stable.legacyPackages.${system};
    pkgs-master = nixpkgs-master.legacyPackages.${system};
    pkgs-prev = nixpkgs-prev.legacyPackages.${system};
  in {
    homeConfigurations.moi = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./home.nix
        nur.nixosModules.nur
      ];
      extraSpecialArgs = {
        inherit rust-overlay pkgs-stable pkgs-master pkgs-prev tree-grepper nixgl;
      };
    };
  };
}
