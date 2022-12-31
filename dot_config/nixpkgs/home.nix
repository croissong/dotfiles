# https://nix-community.github.io/home-manager/options.html
# https://mipmip.github.io/home-manager-option-search/
{
  pkgs,
  pkgs-master,
  config,
  lib,
  rust-overlay,
  tree-grepper,
  ...
}: let
  secrets = import ./secrets.nix;
in {
  nixpkgs.config.allowUnfree = true;
  targets.genericLinux.enable = true;
  programs.home-manager.enable = true;

  systemd.user.sessionVariables = {
    # used by: slack
    NIXOS_OZONE_WL = 1;
  };

  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/misc/termdown/default.nix
  nixpkgs.overlays = [
    rust-overlay.overlays.default
    tree-grepper.overlay.x86_64-linux
    (self: super: {
      termdown = super.termdown.overrideAttrs (prev: rec {
        version = "1.18.0";
        src = super.fetchFromGitHub {
          rev = version;
          sha256 = "sha256-Hnk/MOYdbOl14fI0EFbIq7Hmc7TyhcZWGEg2/jmNJ5Y=";
          repo = "termdown";
          owner = "trehn";
        };
      });
    })
  ];

  imports = [
    ./packages.nix
    ./programs.nix
  ];

  home = {
    stateVersion = "22.05";
    homeDirectory = "/home/croissong";
    username = "croissong";

    # enableNixpkgsReleaseCheck = true;

    packages = with pkgs; [
      calibre # Ebook management application
      i3status-rust # Resourcefriendly and feature-rich replacement for i3status, written in pure Rust

      termdown # Countdown timer and stopwatch in your terminal
      rust-analyzer # Experimental Rust compiler front-end for IDEs
      slack # Slack Desktop for Linux, using the system Electron package
      syncthing # Open Source Continuous Replication / Cluster Synchronization Thing
      wl-color-picker # A wayland color picker that also works on wlroots
      wlsunset # Day/night gamma adjustments for Wayland compositors
    ];

    # only has v11 currently
    file.".local/jdks/openjdk11".source = pkgs.adoptopenjdk-bin; # java jdk 11
  };
}
