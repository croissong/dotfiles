{
  pkgs,
  config,
  lib,
  ...
}: let
  pkgs_stable =
    import
    (builtins.fetchTarball https://github.com/NixOS/nixpkgs/archive/refs/tags/22.05.tar.gz)
    # reuse the current configuration
    {inherit config;};

  my_pkgs = import ./my-pkgs.nix {
    inherit pkgs lib config;
  };

  packages_dict = with pkgs; {
    ent = [
      yt-dlp
    ];

    cli = {
      dev = [
        angle-grinder # Slice and dice logs on the command line
        kubeval # Tool for validating Kubernetes YAML or JSON configuration files
        step-cli # A zero trust swiss army knife for working with X509, OAuth, JWT, OATH OTP, etc.
        skopeo # A command line utility for various operations on container images and image repositories.
      ];

      media = [
        imv # A command line image viewer for tiling window managers
      ];

      data = [
        bcal # Storage conversion and expression calculator
        dasel # Query and update data structures from the command line.
        jq # Command-line JSON processor
        sd # Intuitive find & replace
      ];

      backup = [
        backblaze-b2 # Command-line tool for accessing the Backblaze B2 storage service
      ];

      tools = [
        bat # Cat clone with syntax highlighting and git integration
        broot # Fuzzy Search + tree + cd

        cheat # Allows you to create and view interactive cheatsheets on the command-line
        navi # An interactive cheatsheet tool for the command-line

        dogdns # Command-line DNS client like dig
        jless # A command-line pager for JSON data

        gopass # The slightly more awesome standard unix password manager for teams.
        gopass-summon-provider # summon provider for gopass

        gpg-tui # A terminal user interface for GnuPG
        gron # Make JSON greppable!

        just # A handy way to save and run project-specific commands

        mani # A CLI tool that helps you manage multiple repositories
        ouch # Painless compression and decompression in the terminal (git version)

        podman # Tool and library for running OCI-based containers in pods
        podman-compose # A script to run docker-compose.yml using podman

        termscp # A feature rich terminal UI file transfer and explorer
        termshark # Terminal UI for tshark, inspired by Wireshark

        viddy # A modern watch command
        watchexec # Executes commands in response to file modifications

        yq-go # Portable command-line YAML processor
        zbar # Application and library for reading bar codes from various sources

        libqalculate # An advanced calculator library
      ];
    };

    dev = {
      net = [
        mtr # Combines the functionality of traceroute and ping
        socat # Utility for bidirectional data transfer between two independent data channels
        sshuttle # Transparent proxy server that works as a poor man's VPN
        websocat # Command-line client for WebSockets (like netcat/socat)
      ];

      http = [
        curlie # Frontend to curl that adds the ease of use of httpie, without compromising on features and performance
        httpie # A command line HTTP client whose goal is to make CLI human-friendly
        http-prompt # An interactive HTTP command-line client
      ];

      protocols = [
        swaks # Swiss Army Knife SMTP; Command line SMTP testing, including TLS and AUTH
      ];

      docs = [
        plantuml # Component that allows to quickly write uml diagrams
        glow # Command-line markdown renderer
        python310Packages.grip # Preview GitHub Markdown files like Readme locally before committing them
      ];

      cn = [
        azure-cli # Command-line tools for Azure.
        s3cmd # Command line tool for managing Amazon S3 and CloudFront services
        sops # Mozilla sops (Secrets OPerationS) is an editor of encrypted files
        terraform-docs # A utility to generate documentation from Terraform modules in various output formats
      ];

      editor = [
        stylua # Code formatter for Lua
      ];

      lang = {
        webdev = [
          nodePackages."@angular/cli" # CLI tool for Angular
          nodePackages.create-react-app # Create React apps with no build configuration.
          # TODO: https://github.com/NixOS/nixpkgs/issues/180899
          # nodePackages.gatsby-cli # Gatsby command-line interface for creating new sites
          nodePackages.npm-check-updates # Find newer versions of dependencies than what your package.json allows
          nodePackages.typescript-language-server # Language Server Protocol (LSP) implementation for TypeScript using tsserver
          yarn # Fast, reliable, and secure dependency management
        ];

        java = [
          eclipse-mat # Fast and feature-rich Java heap analyzer
          visualvm # A visual interface for viewing information about Java application
          jetbrains.idea-community # IDE by Jetbrains, community edition
        ];
      };

      data = [
        usql # A universal command-line interface for SQL databases
        dbeaver # Universal SQL Client for developers, DBA and analysts. Supports MySQL, PostgreSQL, MariaDB, SQLite, and more
      ];
    };

    lang = {
      go = [
        golangci-lint # Fast linters Runner for Go
        delve # A debugger for the Go programming language.
        go # Core compiler tools for the Go programming language
        gopls # Language server for Go programming language
        go-tools # Developer tools for the Go programming language
      ];

      jvm = [
        gradle # Powerful build system for the JVM
        maven # Java project management and project comprehension tool
      ];

      python = [
        black # The uncompromising Python code formatter
        python310Packages.flake8 # The modular source code checker
        mypy # Optional static typing for Python 2 and 3 (PEP484)
        poetry # Python dependency management and packaging made easy.
        pyright # Type checker for the Python language
        twine # Collection of utilities for interacting with PyPI
      ];

      rust = [
        cargo-edit # Managing cargo dependencies from the command line
        cargo-make # Rust task runner and build tool
        # required for topgrade cargo step
        cargo-update # A cargo subcommand for checking and applying updates to installed executables
        rust-bin.stable.latest.default
      ];

      shell = [
        shfmt # A shell parser and formatter
      ];
    };

    desktop = {
      cli = [
        grim # Grab images from a Wayland compositor
        croc # Easily and securely send things from one computer to another
        ripgrep # A utility that combines the usability of The Silver Searcher with the raw speed of grep
        slurp # Select a region in a Wayland compositor
        tmpmail # A temporary email right from your terminal written in POSIX sh
      ];
    };

    bizz = {
      fin = [
        electrum # A lightweight Bitcoin wallet
      ];
    };

    media = {
      cli = [
        visidata # Interactive terminal multitool for tabular data
      ];

      images = [
        krita # Edit and paint images

        epick # Color picker for creating harmonic color palettes
      ];
      video = [
        obs-studio # Free, open source software for live streaming and recording
        streamlink # CLI for extracting streams from various websites to video player of your choosing
        streamlink-twitch-gui-bin # Twitch.tv browser for Streamlink
      ];

      audio = [
        cozy # A modern audio book player for Linux using GTK 3
      ];
    };

    shell = {
      tools = [
        pueue # A daemon for managing long running shell commands
        fzf # Command-line fuzzy finder
        sysz # A fzf terminal UI for systemctl

        bottom # A cross-platform graphical process/system monitor with a customizable interface
      ];

      core = [
        mcfly # An upgraded ctrl-r for Bash whose history results make sense for what you're working on right now
      ];
    };

    pim = {
      all = [
        davmail # A Java application which presents a Microsoft Exchange server as local CALDAV, IMAP and SMTP servers

        khal # CLI calendar application build around CalDAV
        khard # Console carddav client
      ];

      bookmarks = [
        buku # Private cmdline bookmark manager
        bukubrow # A WebExtension for Buku, a command-line bookmark manager
        oil-buku # Search-as-you-type cli frontend for the buku bookmarks manager using peco
      ];
    };

    system = {
      cli = [
        procs # A modern replacement for ps written in Rust
        my_pkgs.xdg-ninja # A shell script which checks your $HOME for unwanted files and directories
      ];
    };

    entertain = {
      gaming = [
        # wine-wayland # An Open Source implementation of the Windows API on top of OpenGL and Unix
        # bottles # An easy-to-use wineprefix manager

        lutris # Open Source gaming platform for GNU/Linux
      ];
    };
  };

  packages = with pkgs; {
    cli = [
    ];

    pers = [
      ledger # Double-entry accounting system with a command-line reporting interface
    ];

    media = [
      ffmpeg_5 # Complete solution to record, convert and stream audio and video
      imagemagick
    ];

    vms = [
      libguestfs # Access and modify virtual machine disk images
      quickemu # Quickly create and run optimised Windows, macOS and Linux desktop virtual machines.
      tigervnc
      vagrant # Build and distribute virtualized development environments
      virt-viewer # A lightweight interface for interacting with the graphical display of virtualized guest OS.
      # lxd # Daemon based on liblxc offering a REST API to manage containers
      distrobuilder # System container image builder for LXC and LXD
    ];

    system = [
      du-dust # du + rust = dust. Like du but more intuitive
      duf # Disk Usage/Free Utility
      batsignal # A lightweight battery monitor daemon
      mako # Lightweight notification daemon for Wayland
      pamixer # Pulseaudio command-line mixer like amixer
    ];

    backup = [
      borgbackup # Deduplicating archiver with compression and encryption
      borgmatic # Simple, configuration-driven backup software for servers and workstation
    ];

    shell = [
      starship # The cross-shell prompt for astronauts
      zoxide # A fast cd command that learns your habits
    ];

    nix = [
      nixos-generators
      alejandra
      nix-update
    ];

    tools = [
      ansible # Official assortment of Ansible collections
      ansible-lint # Checks playbooks for practices and behaviour that could potentially be improved.
      python310Packages.mitogen # Python Library for writing distributed self-replicating programs

      dhcping # Send DHCP request to find out if a DHCP server is running

      # TODO (ngrok alternative)
      # rathole # A reverse proxy for NAT traversal
      miniserve # CLI tool to serve files and directories over HTTP
      ngrok # secure introspectable tunnels to localhost
      pastel # A command-line tool to generate, analyze, convert and manipulate colors
      ventoy-bin # A new multiboot USB solution (Binary)
    ];

    dev = [
      checkov # Static code analysis tool for infrastructure-as-code
      cosign # Container Signing CLI with support for ephemeral keys and Sigstore signing
      doctl # The official command line interface for the DigitalOcean API
      go-mockery # A mock code autogenerator for golang
      google-cloud-sdk # A set of command-line tools for the Google Cloud Platform. Includes gcloud (with beta and alpha commands), gsutil, and bq.
      gsctl # The Giant Swarm command line interface
      hexyl # A command-line hex viewer
      ktlint # An anti-bikeshedding Kotlin linter with built-in formatter
      mitmproxy # SSL-capable man-in-the-middle HTTP proxy
      packer # tool for creating identical machine images for multiple platforms from a single source configuration
      pluto # A cli tool to help discover deprecated apiVersions in Kubernetes
      prometheus # An open-source systems monitoring and alerting toolkit
      protobuf # Google's data interchange format
      nodePackages.prettier # An opinionated code formatter for JS, JSON, CSS, YAML and much more
      shellcheck # Shell script analysis tool (binary release)
      terraform # HashiCorp tool for building and updating infrastructure as code idempotently
    ];

    k8s = [
      helmfile # Deploy Kubernetes Helm Charts
      krew # Krew is the package manager for kubectl plugins.
      kubectl # Kubernetes.io client binary
      kubernetes-helm # The Kubernetes Package Manager
      kustomize # Template-free customization of Kubernetes YAML manifests
      telepresence2 # Local development against a remote Kubernetes or OpenShift cluster
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
in {
  home.packages =
    packages.cli
    ++ packages.system
    ++ packages.apps
    ++ packages.media
    ++ packages.dev
    ++ packages.pers
    ++ packages.shell
    ++ packages.vms
    ++ packages.nix
    ++ packages.tools
    ++ packages.backup
    ++ packages.k8s
    ++ builtins.concatLists (lib.attrsets.collect builtins.isList packages_dict);

  systemd.user.sessionVariables.DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/podman/podman.sock";

  nixpkgs.overlays = [
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

    # (self: super: {
    #   mani =
    #     let
    #       version = "0.20.0";
    #       src = pkgs.fetchFromGitHub {
    #         owner = "alajmo";
    #         repo = "mani";
    #         rev = "v${version}";
    #         sha256 = "sha256-o0oOpqGRfdOm/uS8U+H0MzTWBjb5wJBTpDbT/o0Afrc=";
    #       };
    #     in
    #     (pkgs.mani.override rec {
    #       buildGoModule = args: pkgs.buildGoModule.override { go = pkgs.go_1_17; } (args // {
    #         inherit src version;
    #         vendorSha256 = "sha256-NnXQAf8m2cGLvwSOzQWXffiG1zyVqDPQnGAeqe7EUHy=";
    #       });
    #     });
    # })

    (self: super: {
      # https://github.com/NixOS/nixpkgs/issues/107070
      ouch =
        super.rustPlatform.buildRustPackage
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

          nativeBuildInputs = [super.help2man super.installShellFiles super.pkg-config];

          buildInputs = [super.bzip2 super.xz super.zlib super.zstd];

          buildFeatures = ["zstd/pkg-config"];

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
            maintainers = with maintainers; [figsoda psibi];
          };
        };
    })
  ];
}
