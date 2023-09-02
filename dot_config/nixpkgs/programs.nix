{pkgs, ...}: let
in {
  imports = [
    ./firefox.nix
    ./pim.nix
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

  services.wlsunset = {
    enable = true;
    latitude = "51.3";
    longitude = "9.5";
    temperature.night = 2000;
  };

  # TODO: use nixos services + declarative config
  # https://nixos.wiki/wiki/Syncthing
  services.syncthing = {
    enable = true;
  };
}
