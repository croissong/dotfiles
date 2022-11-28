{
  pkgs,
  config,
  ...
}:
with pkgs; let
  kubesess = stdenv.mkDerivation rec {
    pname = "kubesess";
    version = "1.2.8";

    src = fetchurl {
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

  xmlformatter = python3Packages.buildPythonPackage rec {
    pname = "xmlformatter";
    version = "0.2.4";

    src = python3Packages.fetchPypi {
      inherit pname version;
      sha256 = "sha256-bZPEvATP+x1M9uudkDQBjpsmTkVUJp59pnU5ukv/A/U=";
    };
    # checkInputs = [pkgs.python3Packages.pytest pkgs.python3Packages.setuptools];
    # propagatedBuildInputs = [
    #   pkgs.python3Packages.setuptools
    #   pkgs.python3Packages.pytest
    # ];
  wutag = stdenv.mkDerivation rec {
    pname = "wutag";
    version = "0.5.0";

    src = fetchurl {
      url = "https://github.com/vv9k/wutag/releases/download/${version}/wutag-${version}-x86_64-unknown-linux.tar.xz";
      sha256 = "sha256-xpF3rNl9hYAjqWPeZ21UxhuIMVI0VPZx5Gik4/2BFxo=";
    };

    installPhase = ''
      install -m755 -D wutag $out/bin/wutag
    '';

    meta = with lib; {
      homepage = "https://github.com/vv9k/wutag";
      description = "CLI Tool for tagging and organizing files by tags";
    };
  };

  # TODO: https://github.com/NixOS/nixpkgs/blob/master/pkgs/tools/misc/sheldon/default.nix
  sheldon = stdenv.mkDerivation rec {
    pname = "sheldon";
    version = "0.7.1";

    src = fetchurl {
      url = "https://github.com/rossmacarthur/sheldon/releases/download/${version}/sheldon-${version}-x86_64-unknown-linux-musl.tar.gz";
      sha256 = "19h7j89gjsvbaaqr68c7p0sii7692r1kag2x3fnbzjb2ns5l2czk";
    };

    sourceRoot = ".";
    installPhase = ''
      install -m755 -D sheldon $out/bin/sheldon
      runHook postInstall
    '';

    nativeBuildInputs = [installShellFiles];
    postInstall = ''
      installShellCompletion --zsh completions/sheldon.zsh
    '';

    meta = with lib; {
      homepage = "https://github.com/rossmacarthur/sheldon";
      description = "Fast, configurable, shell plugin manager";
    };
  };

  dtool = rustPlatform.buildRustPackage rec {
    pname = "dtool";
    version = "0.12.0";

    src = fetchFromGitHub {
      owner = "guoxbin";
      repo = "dtool";
      rev = "v${version}";
      sha256 = "sha256-hdT3xLO5r5UKVM6Be4zerEi4Wh0653mGXQ9/eoeYSwk=";
    };

    nativeBuildInputs = [pkg-config];
    buildInputs = [bzip2 xz zlib];

    cargoSha256 = "sha256-uQxECH188MwHijtrsBh1+CfDNGYpAgVlh5cH07POB5s=";

    meta = {
      homepage = "https://github.com/guoxbin/dtool";
      description = "CLI tool collection to assist development";
    };
  };

  ytui-music = stdenv.mkDerivation rec {
    pname = "ytui-music";
    version = "2.0.0-beta";

    src = fetchurl {
      url = "https://github.com/sudipghimire533/ytui-music/releases/download/v${version}/ytui_music-linux-amd64";
      sha256 = "sha256-J8CMv19HqC+QLrfuLjAQPNK33lUVsed03hj7sOjdQXw=";
    };

    unpackPhase = ":";
    installPhase = ''
      install -m755 -D $src $out/bin/ytui_music
    '';

    meta = {
      homepage = "https://github.com/sudipghimire533/ytui-music";
      description = "Youtube client in terminal for music";
    };
  };

  go-commitlinter = stdenv.mkDerivation rec {
    pname = "go-commitlinter";
    version = "0.1.2";

    src = fetchurl {
      url = "https://github.com/masahiro331/go-commitlinter/releases/download/${version}/go-commitlinter_${version}_Linux_x86_64.tar.gz";
      sha256 = "sha256-eMECQMw+htty9Izso+g3zODtcXFMorNdWF8rl09pSg8=";
    };

    sourceRoot = ".";
    installPhase = ''
      install -m755 -D go-commitlinter $out/bin/go-commitlinter
    '';

    meta = {
      homepage = "https://github.com/masahiro331/go-commitlinter";
      description = "go-commitlinter is simple commit message linter.";
    };
  };

  csvlens = rustPlatform.buildRustPackage rec {
    pname = "csvlens";
    version = "0.1.9";

    src = fetchFromGitHub {
      owner = "YS-L";
      repo = "csvlens";
      rev = "v0.1.9";
      sha256 = "sha256-HVVUR8nSsnSMhr6gvKAj3vEgIbLpfKI7iJSlXGUrS2M==";
    };

    nativeBuildInputs = [pkg-config];
    buildInputs = [bzip2 xz zlib zstd];

    cargoSha256 = "sha256-qK95TCZUyDdV2X2mEdGwkeh+zCjurwN9gdy6dJgTeQo=";

    meta = {
      homepage = "https://github.com/YS-L/csvlens";
      description = "Command line csv viewer";
    };
  };

  mailctl = stdenv.mkDerivation rec {
    pname = "mailctl";
    version = "0.7.4";

    src = fetchurl {
      url = "https://github.com/pdobsan/mailctl/releases/download/${version}/mailctl-${version}-Linux-x86_64";
      sha256 = "sha256-nBj6vfUfScMTy4rn7qQ8bRaMsSXBiTXQCq6ngjIsU6U==";
    };

    unpackPhase = ":";
    installPhase = ''
      install -m755 -D $src $out/bin/mailctl
    '';

    meta = {
      homepage = "https://github.com/pdobsan/mailctl";
      description = "Provide IMAP/SMTP clients with the capabilities of renewal and authorization of OAuth2 credentials";
    };
  };

  youtube-tui = stdenv.mkDerivation rec {
    pname = "youtube-tui";
    version = "0.5.0";

    src = fetchurl {
      url = "https://github.com/Siriusmart/youtube-tui/releases/download/v${version}/default.youtube-tui_arch-x86_64";
      sha256 = "1yq9azx3hf48cc18a6pxsyknm9qaq0wd7a7maiwmgmc2xmsccs3n";
    };

    buildInputs = [libsixel openssl];
    nativeBuildInputs = [
      autoPatchelfHook # Automatically setup the loader, and do the magic
    ];
    unpackPhase = ":";
    installPhase = ''
      install -m755 -D $src $out/bin/youtube-tui
    '';

    meta = {
      homepage = "https://github.com/Siriusmart/youtube-tui";
      description = "An aesthetically pleasing YouTube TUI written in Rust";
    };
  };

  shellcaster = stdenv.mkDerivation rec {
    pname = "shellcaster";
    version = "2.0.1";

    src = fetchurl {
      url = "https://github.com/jeff-hughes/shellcaster/releases/download/v${version}/shellcaster-${version}-archlinux-x86_64.tar.gz";
      sha256 = "sha256-VwOXOfE5MoP20/1BIe1tIA/xfOzA0iQ4Fy8cEn+fPNY=";
    };

    installPhase = ''
      install -m755 -D shellcaster $out/bin/shellcaster
    '';

    meta = {
      homepage = "https://github.com/jeff-hughes/shellcaster";
      description = "Terminal-based podcast manager built in Rust";
    };
  };

  rusty-krab-manager = rustPlatform.buildRustPackage rec {
    pname = "rusty-krab-manager";
    version = "1.3";

    src = fetchFromGitHub {
      owner = "aryakaul";
      repo = "rusty-krab-manager";
      rev = "v${version}";
      sha256 = "sha256-NiOmXV9gadfBQgFG9BU0e+UmEr023WbhVQCe+FfJaoI=";
    };

    nativeBuildInputs = [pkg-config];
    buildInputs = [alsa-lib];

    cargoSha256 = "sha256-2VVWEC7VnaaSLwq4b5zK9i6ihhBT0ZEBqq/a0VhisfU=";

    meta = with lib; {
      homepage = "https://github.com/aryakaul/rusty-krab-manager";
      description = "time management tui in rust";
    };
  };

  klog = stdenv.mkDerivation rec {
    pname = "klog";
    version = "5.3";

    src = fetchzip {
      url = "https://github.com/jotaen/klog/releases/download/v${version}/klog-linux.zip";
      sha256 = "sha256-WFcaY90gxn8haS9jwtmB14XwnFtaw465QSrvcOnp82w=";
      stripRoot = false;
    };

    installPhase = ''
      install -m755 -D klog $out/bin/klog
    '';

    meta = {
      homepage = "https://github.com/jotaen/klog";
      description = "Command line tool for time tracking";
    };
  };

  versio = stdenv.mkDerivation rec {
    pname = "versio";
    version = "0.6.5";

    src = fetchurl {
      url = "https://github.com/chaaz/versio/releases/download/v${version}/versio__x86_64-unknown-linux-gnu";
      sha256 = "sha256-TEqINf2gp6MVG0QmIdOS6MUZF/RQT75HK5lWjzdA2RM=";
    };

    unpackPhase = ":";
    installPhase = ''
      install -m755 -D $src $out/bin/versio
    '';

    meta = {
      homepage = "https://github.com/chaaz/versio";
      description = "A version number manager";
    };
  };

  focus = stdenv.mkDerivation rec {
    pname = "focus";
    version = "1.2.0";

    src = fetchurl {
      url = "https://github.com/ayoisaiah/focus/releases/download/v${version}/focus_${version}_linux_amd64.tar.gz";
      sha256 = "145hkv91hhcfch0bbn2rcgldc7bjynr7kpl6wg9z28jg7pq02572";
    };

    sourceRoot = ".";
    installPhase = ''
      install -m755 -D focus $out/bin/focus
    '';

    meta = {
      homepage = "https://github.com/ayoisaiah/focus";
      description = "A fully featured productivity timer for the command line, based on the Pomodoro Technique";
    };
  };
in {
  kubesess = kubesess;
  wutag = wutag;
  xmlformatter = xmlformatter;
  sheldon = sheldon;
  cqlsh = cqlsh;
  dtool = dtool;
  ytui-music = ytui-music;
  youtube-tui = youtube-tui;
  go-commitlinter = go-commitlinter;
  csvlens = csvlens;
  mailctl = mailctl;
  shellcaster = shellcaster;
  rusty-krab-manager = rusty-krab-manager;
  klog = klog;
  versio = versio;
  focus = focus;
}
