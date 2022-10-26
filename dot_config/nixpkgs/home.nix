# https://nix-community.github.io/home-manager/options.html
{
  pkgs,
  config,
  lib,
  rust-overlay,
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

  services.wlsunset = {
    enable = true;
    latitude = "51.3";
    longitude = "9.5";
    temperature.night = 2500;
  };

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
      chezmoi # Manage your dotfiles across multiple machines
      i3status-rust # Resourcefriendly and feature-rich replacement for i3status, written in pure Rust

      termdown # Countdown timer and stopwatch in your terminal
      rust-analyzer # Experimental Rust compiler front-end for IDEs
      slack # Slack Desktop for Linux, using the system Electron package
      syncthing # Open Source Continuous Replication / Cluster Synchronization Thing
      wl-color-picker # A wayland color picker that also works on wlroots
      wlsunset # Day/night gamma adjustments for Wayland compositors
    ];

    file = {
      "tmp/packages.txt".text = let
        packages = builtins.map (p: "${p.name}") config.home.packages;
        sortedUnique = builtins.sort builtins.lessThan (lib.unique packages);
        formatted = builtins.concatStringsSep "\n" sortedUnique;
      in
        formatted;
    };

    # only has v11 currently
    file.".local/jdks/openjdk11".source = pkgs.adoptopenjdk-bin; # java jdk 11
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

  programs.mbsync.enable = true;
  accounts.email = {
    maildirBasePath = ".local/share/mail";

    accounts = {
      iogroup = {
        address = secrets.mail.datawerk.username;
        primary = true;
        flavor = "outlook.office365.com";
        passwordCommand = "echo ${secrets.mail.datawerk.password}";

        folders = {
          inbox = "INBOX";
          # TODO: drafts,sent,trash
        };

        imap = {
          port = 993;
          host = "outlook.office365.com";
          tls.enable = true;
        };
        imapnotify = {
          enable = true;
          boxes = ["INBOX" "ops"];
          onNotify = "/usr/bin/mailsync jm@iogroup.org"; # TODO
        };

        maildir = {
          # TODO: remove this and switch maildir references to default: .local/share/mail/iogroup/
          path = "jm@iogroup.org";
        };

        mbsync = {
          enable = true;
          create = "both";
          expunge = "both";
        };
      };
    };
  };

  services = {
    imapnotify.enable = true;
    kdeconnect.enable = true;
  };
  systemd.user.sessionVariables.MOZ_ENABLE_WAYLAND = 1;
}
