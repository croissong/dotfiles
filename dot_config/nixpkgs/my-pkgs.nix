{
  pkgs,
  config,
  ...
}: let
  xdg-ninja = pkgs.stdenv.mkDerivation rec {
    pname = "xdg-ninja";
    version = "0.2.0.1";

    src = pkgs.fetchurl {
      url = "https://github.com/b3nj5m1n/xdg-ninja/releases/download/v${version}/xdgnj";
      sha256 = "sha256-y1BSqKQWbhCyg2sRgMsv8ivmylSUJj6XZ8o+/2oT5ns=";
    };

    phases = ["installPhase"];
    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/xdg-ninja
      chmod +x $out/bin/xdg-ninja
    '';
  };

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
  wutag = pkgs.rustPlatform.buildRustPackage rec {
    pname = "wutag";
    version = "0.5.0";

    src = pkgs.fetchFromGitHub {
      owner = "vv9k";
      repo = "wutag";
      rev = "master";
      sha256 = "sha256-69yD7d3jtfANzkYT6sgMfDjABrDsw5TBmSV/XVsvHVw=";
    };

    nativeBuildInputs = [pkgs.pkg-config];
    buildInputs = [pkgs.bzip2 pkgs.xz pkgs.zlib pkgs.zstd];

    cargoSha256 = "sha256-p4HkmIXIxe+gFb17faUJwi8FDWZBRcciZIyvLgJDccQ=";

    meta = with pkgs.lib; {
      homepage = "https://github.com/vv9k/wutag";
      description = "CLI Tool for tagging and organizing files by tags";
    };
  };

  sheldon =
    pkgs.stdenv.mkDerivation rec {
      pname = "sheldon";
      version = "0.7.0";

      src =
        pkgs.fetchurl {
          url = "https://github.com/rossmacarthur/sheldon/releases/download/${version}/sheldon-${version}-x86_64-unknown-linux-musl.tar.gz
";
          sha256 = "sha256-wkP+Luq9N68o1DpVmixohrgq0pv7ynKTe/Po5+sgxOg=";
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
      rev = "master";
      sha256 = "sha256-hdT3xLO5r5UKVM6Be4zerEi4Wh0653mGXQ9/eoeYSwk=";
    };

    nativeBuildInputs = [pkgs.pkg-config];
    buildInputs = [pkgs.bzip2 pkgs.xz pkgs.zlib];

    cargoSha256 = "sha256-uQxECH188MwHijtrsBh1+CfDNGYpAgVlh5cH07POB5s=";

    meta = with pkgs.lib; {
      homepage = "https://github.com/guoxbin/dtool";
      description = "CLI tool collection to assist development";
      platforms = platforms.linux;
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
    # sourceRoot = ".";
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
      rev = "master";
      sha256 = "sha256-ffxCPYI6NbwidvlqsfZdKhnvnyAR2QVNRDBWCRDWEeQ=";
    };

    nativeBuildInputs = [pkgs.pkg-config];
    buildInputs = [pkgs.bzip2 pkgs.xz pkgs.zlib pkgs.zstd];
    # buildFeatures = ["zstd/pkg-config"];

    cargoSha256 = "sha256-qK95TCZUyDdV2X2mEdGwkeh+zCjurwN9gdy6dJgTeQo=";

    meta = with pkgs.lib; {
      homepage = "https://github.com/YS-L/csvlens";
      description = "Command line csv viewer";
    };
  };

  vhs = pkgs.stdenv.mkDerivation rec {
    pname = "vhs";
    version = "0.1.0";

    src = pkgs.fetchurl {
      url = "https://github.com/charmbracelet/vhs/releases/download/v${version}/vhs_${version}_Linux_x86_64.tar.gz";
      sha256 = "sha256-QUJIvLFagxV2G6fTPoeiTf7M9Kw9iCUDf1H5sqY1Re0=";
    };

    sourceRoot = ".";
    installPhase = ''
      install -m755 -D vhs $out/bin/vhs
    '';

    meta = with pkgs.lib; {
      homepage = "https://github.com/charmbracelet/vhs";
      description = "Your CLI home video recorder vhs";
    };
  };
in {
  xdg-ninja = xdg-ninja;
  kubesess = kubesess;
  wutag = wutag;
  xmlformatter = xmlformatter;
  sheldon = sheldon;
  dtool = dtool;
  ytui-music = ytui-music;
  go-commitlinter = go-commitlinter;
  csvlens = csvlens;
  vhs = vhs;
}
