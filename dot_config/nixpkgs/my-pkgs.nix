{
  pkgs,
  config,
  ...
}: let
  kubesess = pkgs.stdenv.mkDerivation rec {
    pname = "kubesess";
    version = "1.2.8";

    src = pkgs.fetchurl {
      url = "https://github.com/Ramilito/kubesess/releases/download/${version}/kubesess_${version}_x86_64-unknown-linux-gnu.tar.gz";
      sha256 = "sha256-VIhadJ/9RTmHKEI7zzc+ZSXOl9gY0X4NhEXNgbmlwqE=";
    };

    phases = ["unpackPhase" "installPhase"];
    unpackPhase = ''
      tar zxpf $src -C .
    '';
    installPhase = ''
      mkdir -p $out/bin
      cp target/x86_64-unknown-linux-gnu/release/kubesess $out/bin/kubesess
      mkdir -p $out/share/${pname}
      cp -r scripts $out/share/${pname}/scripts
    '';
  };

  xmlformatter = pkgs.python3Packages.buildPythonPackage rec {
    pname = "xmlformatter";
    version = "0.2.4";

    src = pkgs.python3Packages.fetchPypi {
      inherit pname version;
      sha256 = "sha256-bZPEvATP+x1M9uudkDQBjpsmTkVUJp59pnU5ukv/A/U=";
    };
    # checkInputs = [pkgs.python3Packages.pytest pkgs.python3Packages.setuptools];
    # propagatedBuildInputs = [
    #   pkgs.python3Packages.setuptools
    #   pkgs.python3Packages.pytest
    # ];
  wutag = pkgs.stdenv.mkDerivation rec {
    pname = "wutag";
    version = "0.5.0";

    src = pkgs.fetchurl {
      url = "https://github.com/vv9k/wutag/releases/download/${version}/wutag-${version}-x86_64-unknown-linux.tar.xz";
      sha256 = "sha256-xpF3rNl9hYAjqWPeZ21UxhuIMVI0VPZx5Gik4/2BFxo=";
    };

    # sourceRoot = ".";
    installPhase = ''
      install -m755 -D wutag $out/bin/wutag
    '';

    meta = with pkgs.lib; {
      homepage = "https://github.com/vv9k/wutag";
      description = "CLI Tool for tagging and organizing files by tags";
    };
  };

  sheldon = pkgs.stdenv.mkDerivation rec {
    pname = "sheldon";
    version = "0.7.1";

    src = pkgs.fetchurl {
      url = "https://github.com/rossmacarthur/sheldon/releases/download/${version}/sheldon-${version}-x86_64-unknown-linux-musl.tar.gz";
      sha256 = "19h7j89gjsvbaaqr68c7p0sii7692r1kag2x3fnbzjb2ns5l2czk";
    };

    sourceRoot = ".";
    installPhase = ''
      install -m755 -D sheldon $out/bin/sheldon
      runHook postInstall
    '';

    nativeBuildInputs = [pkgs.installShellFiles];
    postInstall = ''
      installShellCompletion --zsh completions/sheldon.zsh
    '';

    meta = with pkgs.lib; {
      homepage = "https://github.com/rossmacarthur/sheldon";
      description = "Fast, configurable, shell plugin manager";
    };
  };

  dtool = pkgs.rustPlatform.buildRustPackage rec {
    pname = "dtool";
    version = "0.12.0";

    src = pkgs.fetchFromGitHub {
      owner = "guoxbin";
      repo = "dtool";
      rev = "v${version}";
      sha256 = "sha256-hdT3xLO5r5UKVM6Be4zerEi4Wh0653mGXQ9/eoeYSwk=";
    };

    nativeBuildInputs = [pkgs.pkg-config];
    buildInputs = [pkgs.bzip2 pkgs.xz pkgs.zlib];

    cargoSha256 = "sha256-uQxECH188MwHijtrsBh1+CfDNGYpAgVlh5cH07POB5s=";

    meta = with pkgs.lib; {
      homepage = "https://github.com/guoxbin/dtool";
      description = "CLI tool collection to assist development";
    };
  };

  ytui-music = pkgs.stdenv.mkDerivation rec {
    pname = "ytui-music";
    version = "2.0.0-beta";

    src = pkgs.fetchurl {
      url = "https://github.com/sudipghimire533/ytui-music/releases/download/v${version}/ytui_music-linux-amd64";
      sha256 = "sha256-J8CMv19HqC+QLrfuLjAQPNK33lUVsed03hj7sOjdQXw=";
    };

    phases = ["installPhase"];
    installPhase = ''
      install -m755 -D $src $out/bin/ytui_music
    '';

    meta = with pkgs.lib; {
      homepage = "https://github.com/sudipghimire533/ytui-music";
      description = "Youtube client in terminal for music";
    };
  };

  go-commitlinter = pkgs.stdenv.mkDerivation rec {
    pname = "go-commitlinter";
    version = "0.1.2";

    src = pkgs.fetchurl {
      url = "https://github.com/masahiro331/go-commitlinter/releases/download/${version}/go-commitlinter_${version}_Linux_x86_64.tar.gz";
      sha256 = "sha256-eMECQMw+htty9Izso+g3zODtcXFMorNdWF8rl09pSg8=";
    };

    sourceRoot = ".";
    installPhase = ''
      install -m755 -D go-commitlinter $out/bin/go-commitlinter
    '';

    meta = with pkgs.lib; {
      homepage = "https://github.com/masahiro331/go-commitlinter";
      description = "go-commitlinter is simple commit message linter.";
    };
  };

  csvlens = pkgs.rustPlatform.buildRustPackage rec {
    pname = "csvlens";
    version = "0.1.9";

    src = pkgs.fetchFromGitHub {
      owner = "YS-L";
      repo = "csvlens";
      rev = "v0.1.9";
      sha256 = "sha256-HVVUR8nSsnSMhr6gvKAj3vEgIbLpfKI7iJSlXGUrS2M==";
    };

    nativeBuildInputs = [pkgs.pkg-config];
    buildInputs = [pkgs.bzip2 pkgs.xz pkgs.zlib pkgs.zstd];

    cargoSha256 = "sha256-qK95TCZUyDdV2X2mEdGwkeh+zCjurwN9gdy6dJgTeQo=";

    meta = with pkgs.lib; {
      homepage = "https://github.com/YS-L/csvlens";
      description = "Command line csv viewer";
    };
  };

  mailctl = pkgs.stdenv.mkDerivation rec {
    pname = "mailctl";
    version = "0.7.4";

    src = pkgs.fetchurl {
      url = "https://github.com/pdobsan/mailctl/releases/download/${version}/mailctl-${version}-Linux-x86_64";
      sha256 = "sha256-nBj6vfUfScMTy4rn7qQ8bRaMsSXBiTXQCq6ngjIsU6U==";
    };

    phases = ["installPhase"];
    installPhase = ''
      install -m755 -D $src $out/bin/mailctl
    '';

    meta = with pkgs.lib; {
      homepage = "https://github.com/pdobsan/mailctl";
      description = "Provide IMAP/SMTP clients with the capabilities of renewal and authorization of OAuth2 credentials";
    };
  };

  youtube-tui = pkgs.stdenv.mkDerivation rec {
    pname = "youtube-tui";
    version = "0.5.0";

    src = pkgs.fetchurl {
      url = "https://github.com/Siriusmart/youtube-tui/releases/download/v${version}/default.youtube-tui_arch-x86_64";
      sha256 = "1yq9azx3hf48cc18a6pxsyknm9qaq0wd7a7maiwmgmc2xmsccs3n";
    };

    phases = ["installPhase"];
    buildInputs = [libsixel openssl];
    nativeBuildInputs = [
      autoPatchelfHook # Automatically setup the loader, and do the magic
    ];
    installPhase = ''
      install -m755 -D $src $out/bin/youtube-tui
    '';

    meta = with pkgs.lib; {
      homepage = "https://github.com/Siriusmart/youtube-tui";
      description = "An aesthetically pleasing YouTube TUI written in Rust";
    };
  };

  shellcaster = pkgs.stdenv.mkDerivation rec {
    pname = "shellcaster";
    version = "2.0.1";

    src = pkgs.fetchurl {
      url = "https://github.com/jeff-hughes/shellcaster/releases/download/v${version}/shellcaster-${version}-archlinux-x86_64.tar.gz";
      sha256 = "sha256-VwOXOfE5MoP20/1BIe1tIA/xfOzA0iQ4Fy8cEn+fPNY=";
    };

    installPhase = ''
      install -m755 -D shellcaster $out/bin/shellcaster
    '';

    meta = with pkgs.lib; {
      homepage = "https://github.com/jeff-hughes/shellcaster";
      description = "Terminal-based podcast manager built in Rust";
    };
  };

  rusty-krab-manager = pkgs.rustPlatform.buildRustPackage rec {
    pname = "rusty-krab-manager";
    version = "1.3";

    src = pkgs.fetchFromGitHub {
      owner = "aryakaul";
      repo = "rusty-krab-manager";
      rev = "v${version}";
      sha256 = "sha256-NiOmXV9gadfBQgFG9BU0e+UmEr023WbhVQCe+FfJaoI=";
    };

    nativeBuildInputs = [pkgs.pkg-config];
    buildInputs = [pkgs.alsa-lib];

    cargoSha256 = "sha256-2VVWEC7VnaaSLwq4b5zK9i6ihhBT0ZEBqq/a0VhisfU=";

    meta = with pkgs.lib; {
      homepage = "https://github.com/aryakaul/rusty-krab-manager";
      description = "time management tui in rust";
    };
  };

  klog = pkgs.stdenv.mkDerivation rec {
    pname = "klog";
    version = "5.3";

    src = pkgs.fetchzip {
      url = "https://github.com/jotaen/klog/releases/download/v${version}/klog-linux.zip";
      sha256 = "sha256-WFcaY90gxn8haS9jwtmB14XwnFtaw465QSrvcOnp82w=";
      stripRoot = false;
    };

    installPhase = ''
      install -m755 -D klog $out/bin/klog
    '';

    meta = with pkgs.lib; {
      homepage = "https://github.com/jotaen/klog";
      description = "Command line tool for time tracking";
    };
  };
in {
  kubesess = kubesess;
  wutag = wutag;
  xmlformatter = xmlformatter;
  sheldon = sheldon;
  dtool = dtool;
  ytui-music = ytui-music;
  youtube-tui = youtube-tui;
  go-commitlinter = go-commitlinter;
  csvlens = csvlens;
  mailctl = mailctl;
  shellcaster = shellcaster;
  rusty-krab-manager = rusty-krab-manager;
  klog = klog;
}
