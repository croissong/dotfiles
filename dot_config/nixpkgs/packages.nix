{ pkgs, ... }:
let
  packages = with pkgs; {
    cli = [
      bat               # Cat clone with syntax highlighting and git integration
      jless # A command-line pager for JSON data

      gopass                 # The slightly more awesome standard unix password manager for teams.
      gopass-summon-provider # summon provider for gopass

      podman            # Tool and library for running OCI-based containers in pods
      podman-compose    # A script to run docker-compose.yml using podman

      yq-go # Portable command-line YAML processor
    ];


    system = [
      batsignal # A lightweight battery monitor daemon
      mako # Lightweight notification daemon for Wayland
    ];


    apps = [
      ungoogled-chromium # A lightweight approach to removing Google web service dependency
      zoom             # Video Conferencing and Web Conferencing Service
    ];


    unused = [
      ugrep # ultra fast grep with interactive TUI, fuzzy search, boolean queries, hexdumps and more
    ];
  };
in
{
  home.packages =
    packages.cli
    ++ packages.system
    ++ packages.apps;



  systemd.user.sessionVariables.DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/podman/podman.sock";

  nixpkgs.overlays = [
    (self: super: {
      batsignal = super.batsignal.overrideAttrs (prev: rec {
        version = "1.5.0";
        src = super.fetchFromGitHub {
          rev = version;
          sha256 = "sha256-gZMGbw7Ij1IVQSWOqG/91YrbWTG3I3l6Yp11QbVCfyY=";
          repo = "batsignal";
          owner = "electrickite";
        };
      });
    })

    (self: super: {
      mako = super.mako.overrideAttrs (prev: rec {
        version = "0d95a1653616454e894f27edc329a9f3a7f96dc2";

        src = super.fetchFromGitHub {
          owner = "emersion";
          repo = super.mako.pname;
          rev = "0d95a1653616454e894f27edc329a9f3a7f96dc2";
          sha256 = "sha256-06UDXVsC7jDd/Lq7dSu3ZnkGW9rLiGHSJLoG9SZi1HY=";
        };
      });
    })
  ];
}
