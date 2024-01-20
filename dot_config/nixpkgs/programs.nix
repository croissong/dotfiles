{pkgs, ...}: let
in {
  imports = [
    ./backup.nix
  ];

  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
    commandLineArgs = [
      "--enable-webrtc-pipewire-capturer"
      "--enable-features=UseOzonePlatform"
      "--ozone-platform=wayland"
    ];
  };

  # TODO: use nixos services + declarative config
  # https://nixos.wiki/wiki/Syncthing
  services.syncthing = {
    enable = true;
  };
}
