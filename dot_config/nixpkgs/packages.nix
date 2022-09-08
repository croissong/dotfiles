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

    docs = [
      logseq # A local-first, non-linear, outliner notebook for organizing and sharing your personal knowledge base
    ];

    daily = [
      # vivaldi
      # vivaldi-ffmpeg-codecs
    ];

    special_purpose = [
      tesseract # An OCR program
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
        miller # Like awk, sed, cut, join, and sort for data formats such as CSV, TSV, JSON, JSON Lines, and positionally-indexed
        sd # Intuitive find & replace
      ];

      pipe = [
        choose # A human-friendly and fast alternative to cut and (sometimes) awk
        sad # CLI tool to search and replace
      ];

      backup = [
        backblaze-b2 # Command-line tool for accessing the Backblaze B2 storage service
      ];

      tools = [
        age # Modern encryption tool with small explicit keys
        b3sum # BLAKE3 cryptographic hash function
        bat # Cat clone with syntax highlighting and git integration
        broot # Fuzzy Search + tree + cd

        cheat # Allows you to create and view interactive cheatsheets on the command-line
        navi # An interactive cheatsheet tool for the command-line

        delta # A syntax-highlighting pager for git
        dogdns # Command-line DNS client like dig
        jless # A command-line pager for JSON data

        gopass # The slightly more awesome standard unix password manager for teams.
        gopass-summon-provider # summon provider for gopass

        gpg-tui # A terminal user interface for GnuPG
        gron # Make JSON greppable!

        gum # Tasty Bubble Gum for your shell

        just # A handy way to save and run project-specific commands

        mani # A CLI tool that helps you manage multiple repositories
        ookla-speedtest # Internet speedtest tool
        ouch # Painless compression and decompression in the terminal (git version)

        podman # Tool and library for running OCI-based containers in pods
        podman-compose # A script to run docker-compose.yml using podman

        summon # CLI that provides on-demand secrets access for common DevOps tools

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
        xh # Friendly and fast tool for sending HTTP requests
        mtr # Combines the functionality of traceroute and ping
        socat # Utility for bidirectional data transfer between two independent data channels
        sshuttle # Transparent proxy server that works as a poor man's VPN
        sslscan # Tests SSL/TLS services and discover supported cipher suites
        websocat # Command-line client for WebSockets (like netcat/socat)
      ];

      http = [
        curlie # Frontend to curl that adds the ease of use of httpie, without compromising on features and performance
        httpie # A command line HTTP client whose goal is to make CLI human-friendly
        http-prompt # An interactive HTTP command-line client
      ];

      protocols = [
        altair # A feature-rich GraphQL Client IDE
        grpcurl # Like cURL, but for gRPC: Command-line tool for interacting with gRPC servers
        swaks # Swiss Army Knife SMTP; Command line SMTP testing, including TLS and AUTH
      ];

      docs = [
        asciidoctor-with-extensions
        drawio # A desktop application for creating diagrams
        plantuml # Component that allows to quickly write uml diagrams
        glow # Command-line markdown renderer
        python310Packages.grip # Preview GitHub Markdown files like Readme locally before committing them
      ];

      stuff = [
        powershell
      ];

      cn = [
        argocd # Declarative continuous deployment for Kubernetes
        azure-cli
        k6 # A modern load testing tool, using Go and JavaScript
        linkerd
        s3cmd # Command line tool for managing Amazon S3 and CloudFront services
        sops # Mozilla sops (Secrets OPerationS) is an editor of encrypted files
        terraform-docs # A utility to generate documentation from Terraform modules in various output formats
      ];

      cicd = [
        # codeowners
      ];

      edit = [
        neovim
        stylua # Code formatter for Lua
        treefmt
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

        misc = [
          go-jsonnet
          xxHash # Extremely fast hash algorithm
        ];

        db = [
          mongosh # The MongoDB Shell
          redli # A humane alternative to the Redis-cli and TLS
        ];
      };

      data = [
        usql # A universal command-line interface for SQL databases
        dbeaver # Universal SQL Client for developers, DBA and analysts. Supports MySQL, PostgreSQL, MariaDB, SQLite, and more
        xsv # A fast CSV toolkit written in Rust
      ];
    };

    lang = {
      go = [
        ginkgo # A Modern Testing Framework for Go
        golangci-lint # Fast linters Runner for Go
        delve # A debugger for the Go programming language.
        go # Core compiler tools for the Go programming language
        gopls # Language server for Go programming language
        go-tools # Developer tools for the Go programming language
        revive # Fast, configurable, extensible, flexible, and beautiful linter for Go
      ];

      jvm = [
        gradle # Powerful build system for the JVM
        maven # Java project management and project comprehension tool
      ];

      python = [
        black # The uncompromising Python code formatter
        python310Packages.flake8 # The modular source code checker
        py-spy # Sampling profiler for Python programs
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

      xml = [
        my_pkgs.xmlformatter
      ];
    };

    desktop = {
      cli = [
        croc # Easily and securely send things from one computer to another
        goimapnotify # Execute scripts on IMAP mailbox changes using IDLE
        grim # Grab images from a Wayland compositor
        hydroxide # A third-party, open-source ProtonMail CardDAV, IMAP and SMTP bridge

        topgrade # Invoke the upgrade procedure of multiple package managers
        ripgrep # A utility that combines the usability of The Silver Searcher with the raw speed of grep
        amber # A code search-and-replace tool
        slurp # Select a region in a Wayland compositor
        tmpmail # A temporary email right from your terminal written in POSIX sh
      ];

      wm = [
        wob # A lightweight overlay bar for Wayland
        swappy # A Wayland native snapshot editing tool
      ];

      docs = [
        zathura # A highly customizable and functional PDF viewer
      ];

      odre = [
        kbfs # The Keybase filesystem
        keybase
        keybase-gui

        nvchecker # New version checker for software
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

        # For emacs-gif-screencast
        gifsicle # Command-line tool for creating, editing, and getting information about GIF images and animations

        # TODO: not sure if these are needed (directly)
        gifski # GIF encoder based on libimagequant (pngquant)
        pngquant # Command-line utility to quantize PNGs down to 8-bit paletted PNGs

        image_optim # Command line to optimize jpeg, png, gif and svg images using external utilities (advpng, gifsicle, jhead, jpeg-recompress, jpegoptim, jpegrescan, jpegtran, optipng, pngcrush, pngout, pngquant, svgo)
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

      comm = [
        mumble # low-latency, high quality voice chat software
      ];
    };

    shell = {
      tools = [
        exa # ls replacement
        fd # A simple, fast and user-friendly alternative to find
        pueue # A daemon for managing long running shell commands
        fzf # Command-line fuzzy finder
        sysz # A fzf terminal UI for systemctl
        xplr # A hackable, minimal, fast TUI file explorer
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
        bottom # A cross-platform graphical process/system monitor with a customizable interface
        clamav # Anti-virus toolkit for Unix
        light # GNU/Linux application to control backlights
        procs # A modern replacement for ps written in Rust
        my_pkgs.xdg-ninja # A shell script which checks your $HOME for unwanted files and directories
        trash-cli # Command line tool for the desktop trash can
        nethogs # A small 'net top' tool, grouping bandwidth by process
      ];
    };

    entertain = {
      gaming = [
        # wine-wayland # An Open Source implementation of the Windows API on top of OpenGL and Unix
        # bottles # An easy-to-use wineprefix manager

        lutris # Open Source gaming platform for GNU/Linux
      ];

      media = [
        blanket # Improve focus and increase your productivity by listening to different sounds
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
      dua # A tool to conveniently learn about the disk usage of directories, fast!
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
      alejandra
      nixos-generators
      nix-update

      # not used for now
      # nvd
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
      # TODO: build failure -> https://github.com/NixOS/nixpkgs/blob/master/pkgs/development/tools/analysis/checkov/default.nix
      # checkov # Static code analysis tool for infrastructure-as-code
      caddy # Fast, cross-platform HTTP/2 web server with automatic HTTPS
      cosign # Container Signing CLI with support for ephemeral keys and Sigstore signing
      doctl # The official command line interface for the DigitalOcean API
      gh # GitHub CLI too
      go-mockery # A mock code autogenerator for golang
      google-cloud-sdk # A set of command-line tools for the Google Cloud Platform. Includes gcloud (with beta and alpha commands), gsutil, and bq.
      gsctl # The Giant Swarm command line interface
      hexyl # A command-line hex viewer
      jwt-cli # A super fast CLI tool to decode and encode JWTs
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
      kubelogin # A Kubernetes credential plugin implementing Azure authentication
      my_pkgs.kubesess
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
}
