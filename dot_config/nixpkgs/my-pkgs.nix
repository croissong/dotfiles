{
  pkgs,
  config,
  generated,
  versions,
  ...
}:
with pkgs; let
  kubesess = stdenv.mkDerivation rec {
    pname = "kubesess";
    version = generated.kubesess.version;
    src = generated.kubesess.src;

    sourceRoot = ".";
    installPhase = ''
      install -m755 -D target/x86_64-unknown-linux-gnu/release/kubesess $out/bin/kubesess
      mkdir -p $out/share/${pname}
      cp -r scripts $out/share/${pname}/scripts

      runHook postInstall
    '';

    # TODO: shellcompletion
    # nativeBuildInputs = [installShellFiles];
    # postInstall = ''
    #   installShellCompletion --zsh --name _kubesess scripts/sh/completion.sh
    # '';

    meta = {
      homepage = "https://github.com/Ramilito/kubesess";
      description = "Kubectl plugin managing sessions";
    };
  };

  xmlformatter = python3Packages.buildPythonPackage rec {
    pname = "xmlformatter";
    version = generated.xmlformatter.version;
    src = generated.xmlformatter.src;
  };

  cqlsh = python3Packages.buildPythonPackage rec {
    pname = "cqlsh";
    version = generated.cqlsh.version;
    src = generated.cqlsh.src;

    propagatedBuildInputs = with python310Packages; [
      cassandra-driver
      # six
      # cql
    ];
  };

  wutag = stdenv.mkDerivation rec {
    pname = "wutag";
    version = generated.wutag.version;
    src = generated.wutag.src;

    installPhase = ''
      install -m755 -D wutag $out/bin/wutag
    '';

    meta = {
      homepage = "https://github.com/vv9k/wutag";
      description = "CLI Tool for tagging and organizing files by tags";
    };
  };

  # TODO: https://github.com/NixOS/nixpkgs/blob/master/pkgs/tools/misc/sheldon/default.nix
  sheldon = stdenv.mkDerivation rec {
    pname = "sheldon";
    version = generated.sheldon.version;
    src = generated.sheldon.src;

    sourceRoot = ".";
    installPhase = ''
      install -m755 -D sheldon $out/bin/sheldon
      runHook postInstall
    '';
    nativeBuildInputs = [installShellFiles];
    postInstall = ''
      installShellCompletion --zsh completions/sheldon.zsh
    '';

    meta = {
      homepage = "https://github.com/rossmacarthur/sheldon";
      description = "Fast, configurable, shell plugin manager";
    };
  };

  dtool = rustPlatform.buildRustPackage rec {
    pname = "dtool";
    version = generated.dtool.version;
    src = generated.dtool.src;
    cargoLock = generated.dtool.cargoLock."Cargo.lock";

    nativeBuildInputs = [pkg-config];
    buildInputs = [bzip2 xz zlib];

    meta = {
      homepage = "https://github.com/guoxbin/dtool";
      description = "CLI tool collection to assist development";
    };
  };

  ytui-music = stdenv.mkDerivation rec {
    pname = "ytui-music";
    version = generated.ytui-music.version;
    src = generated.ytui-music.src;

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
    version = generated.go-commitlinter.version;
    src = generated.go-commitlinter.src;

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
    version = generated.csvlens.version;
    src = generated.csvlens.src;
    cargoLock = generated.csvlens.cargoLock."Cargo.lock";

    nativeBuildInputs = [pkg-config];
    buildInputs = [bzip2 xz zlib zstd];

    meta = {
      homepage = "https://github.com/YS-L/csvlens";
      description = "Command line csv viewer";
    };
  };

  mailctl = stdenv.mkDerivation rec {
    pname = "mailctl";
    version = generated.mailctl.version;
    src = generated.mailctl.src;

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
    version = generated.youtube-tui.version;
    src = generated.youtube-tui.src;

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
    version = generated.shellcaster.version;
    src = generated.shellcaster.src;

    installPhase = ''
      install -m755 -D shellcaster $out/bin/shellcaster
    '';

    meta = {
      homepage = "https://github.com/jeff-hughes/shellcaster";
      description = "Terminal-based podcast manager built in Rust";
    };
  };

  klog = stdenv.mkDerivation rec {
    pname = "klog";
    version = generated.klog.version;
    src = fetchzip {
      url = "https://github.com/jotaen/klog/releases/download/v${generated.klog.version}/klog-linux.zip";
      sha256 = "sha256-SOwuzxWWdo0vMw+vdSt2lVABPPzywlWEOKN8e0QugzA=";
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
    version = generated.versio.version;
    src = generated.versio.src;

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
    version = generated.focus.version;
    src = generated.focus.src;
    sourceRoot = ".";
    installPhase = ''
      install -m755 -D focus $out/bin/focus
    '';
    meta = {
      homepage = "https://github.com/ayoisaiah/focus";
      description = "A fully featured productivity timer for the command line, based on the Pomodoro Technique";
    };
  };

  gup = stdenv.mkDerivation rec {
    pname = "gup";
    version = generated.gup.version;
    src = generated.gup.src;

    sourceRoot = ".";
    installPhase = ''
      install -m755 -D gup $out/bin/gup
    '';
    meta = {
      homepage = "https://github.com/nao1215/gup";
      description = "Update binaries installed by go install";
    };
  };

  kubeshark = stdenv.mkDerivation rec {
    pname = "kubeshark";
    version = generated.kubeshark.version;
    src = generated.kubeshark.src;

    unpackPhase = ":";
    installPhase = ''
      install -m755 -D $src $out/bin/kubeshark
    '';
    meta = {
      homepage = "https://github.com/kubeshark/kubeshark";
      description = "The API traffic viewer for Kubernetes. Think TCPDump and Wireshark re-invented for Kubernetes";
    };
  };

  sttr = stdenv.mkDerivation rec {
    pname = "sttr";
    version = generated.sttr.version;
    src = generated.sttr.src;
    sourceRoot = ".";
    installPhase = ''
      install -m755 -D sttr $out/bin/sttr
      runHook postInstall
    '';
    nativeBuildInputs = [installShellFiles];
    postInstall = ''
      installShellCompletion --cmd sttr --zsh <($out/bin/sttr completion zsh)
    '';

    meta = {
      homepage = "https://github.com/abhimanyu003/sttr";
      description = "cross-platform, cli app to perform various operations on string";
    };
  };

  termshot = stdenv.mkDerivation rec {
    pname = "termshot";
    version = generated.termshot.version;
    src = generated.termshot.src;

    sourceRoot = ".";
    installPhase = ''
      install -m755 -D termshot $out/bin/termshot
    '';

    meta = {
      homepage = "https://github.com/homeport/termshot";
      description = "Creates screenshots based on terminal command output ";
    };
  };

  riff = stdenv.mkDerivation rec {
    pname = "riff";
    version = generated.riff.version;
    src = generated.riff.src;

    unpackPhase = ":";
    installPhase = ''
      install -m755 -D $src $out/bin/riff
    '';

    meta = {
      homepage = "https://github.com/walles/riff";
      description = "A diff filter highlighting which line parts have changed";
    };
  };

  aiac = stdenv.mkDerivation rec {
    pname = "aiac";
    version = generated.aiac.version;
    src = generated.aiac.src;

    sourceRoot = ".";
    installPhase = ''
      install -m755 -D aiac $out/bin/aiac
    '';

    meta = {
      homepage = "https://github.com/gofireflyio/aiac";
      description = "Artificial Intelligence Infrastructure-as-Code Generator";
    };
  };

  updatecli = stdenv.mkDerivation rec {
    PROJECT_ROOT = builtins.toString ./.;
    pname = "updatecli";
    version = versions.updatecli.version;
    src = fetchurl {
      url = "https://github.com/updatecli/updatecli/releases/download/v${version}/updatecli_Linux_x86_64.tar.gz";
      sha256 = versions.updatecli.sha;
    };

    sourceRoot = ".";
    installPhase = ''
      install -m755 -D updatecli $out/bin/updatecli
    '';

    meta = {
      homepage = "https://github.com/updatecli/updatecli";
      description = "A Declarative Dependency Management tool ";
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
  klog = klog;
  versio = versio;
  focus = focus;
  gup = gup;
  kubeshark = kubeshark;
  sttr = sttr;
  termshot = termshot;
  riff = riff;
  aiac = aiac;
  updatecli = updatecli;
}
