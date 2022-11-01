{pkgs, ...}: let
in {
  imports = [
    ./firefox.nix
    ./mail.nix
  ];

  programs = {
    go = {
      enable = true;
    };

    java = {
      enable = true;
    };
  };

  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
    commandLineArgs = [
      "--enable-webrtc-pipewire-capturer"
      "--enable-features=UseOzonePlatform"
      "--ozone-platform=wayland"
    ];
  };

  services = {
    kdeconnect.enable = true;
  };
}
