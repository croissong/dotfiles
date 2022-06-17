{ pkgs, ... }:
let
  packages = with pkgs; {
    cli = [
      bat # Cat clone with syntax highlighting and git integration
      jless # A command-line pager for JSON data

      gopass # The slightly more awesome standard unix password manager for teams.
      gopass-summon-provider # summon provider for gopass

      ouch # Painless compression and decompression in the terminal (git version)

      podman # Tool and library for running OCI-based containers in pods
      podman-compose # A script to run docker-compose.yml using podman

      termshark # Terminal UI for tshark, inspired by Wireshark

      yq-go # Portable command-line YAML processor
      zbar # Application and library for reading bar codes from various sources
    ];


    pers = [
      ledger # Double-entry accounting system with a command-line reporting interface
    ];

    media = [
      ffmpeg_5 # Complete solution to record, convert and stream audio and video
    ];


    system = [
      du-dust # du + rust = dust. Like du but more intuitive
      duf # Disk Usage/Free Utility
      batsignal # A lightweight battery monitor daemon
      mako # Lightweight notification daemon for Wayland
      pamixer # Pulseaudio command-line mixer like amixer
    ];

    shell = [
      starship # The cross-shell prompt for astronauts
    ];


    dev = [
      checkov
      doctl # The official command line interface for the DigitalOcean API
      go-mockery # A mock code autogenerator for golang
      google-cloud-sdk # A set of command-line tools for the Google Cloud Platform. Includes gcloud (with beta and alpha commands), gsutil, and bq.
      mitmproxy # SSL-capable man-in-the-middle HTTP proxy
      mypy # Optional static typing for Python 2 and 3 (PEP484)
      packer # tool for creating identical machine images for multiple platforms from a single source configuration
      pluto # A cli tool to help discover deprecated apiVersions in Kubernetes
      nodePackages.prettier # An opinionated code formatter for JS, JSON, CSS, YAML and much more
      shellcheck # Shell script analysis tool (binary release)
      terraform # HashiCorp tool for building and updating infrastructure as code idempotently
    ];


    apps = [
      gnome-podcasts # Podcast application for GNOME
      inkscape # Professional vector graphics editor
      libreoffice-fresh # LibreOffice branch which contains new features and program enhancements

      # https://github.com/guibou/nixGL
      # mpv              # a free, open source, and cross-platform media player

      tenacity # FLOSS Audacity Fork. No telemetry, crash reports and other shenanigans like that!

      ungoogled-chromium # A lightweight approach to removing Google web service dependency
      zoom # Video Conferencing and Web Conferencing Service


      # https://nixos.wiki/wiki/Accelerated_Video_Playback
      intel-media-driver
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
    ++ packages.apps
    ++ packages.media
    ++ packages.dev
    ++ packages.pers
    ++ packages.shell;



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


    (self: super: {
      # https://github.com/NixOS/nixpkgs/issues/107070
      ouch = super.rustPlatform.buildRustPackage
        rec {
          pname = "ouch";
          version = "0.3.1-next";

          src = super.fetchFromGitHub {
            owner = "ouch-org";
            repo = pname;
            rev = "fc532d81d8136cc69eb73bdf3c3d65faede7a596";
            sha256 = "sha256-Qj2CvplJBfgrAep4ivVXiNKDQN2S4R1hdlqZ4S2+MnY=";
          };

          cargoSha256 = "sha256-Qj2CvplJBfgrAep4ivVXiNKDQN2S4R1hdlqZ4S2+MnR=";
          cargoHash = "sha256-RsvpFrwX7QhKpOevH9OnG/E0vRbBpSWLO2j6NUVT/Sg=";


          nativeBuildInputs = [ super.help2man super.installShellFiles super.pkg-config ];

          buildInputs = [ super.bzip2 super.xz super.zlib super.zstd ];

          buildFeatures = [ "zstd/pkg-config" ];

          postInstall = ''
            help2man $out/bin/ouch > ouch.1
            installManPage ouch.1

            completions=($releaseDir/build/ouch-*/out/completions)
            installShellCompletion $completions/ouch.{bash,fish} --zsh $completions/_ouch
          '';

          GEN_COMPLETIONS = 1;

          meta = with super.lib; {
            description = "A command-line utility for easily compressing and decompressing files and directories";
            homepage = "https://github.com/ouch-org/ouch";
            license = licenses.mit;
            maintainers = with maintainers; [ figsoda psibi ];
          };
        };
    })
  ];
}
