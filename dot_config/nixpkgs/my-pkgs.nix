{
  pkgs,
  config,
  versions,
  ...
}:
with pkgs; let
  kubesess = stdenv.mkDerivation rec {
    pname = "kubesess";
    version = versions.kubesess.version;
    src = fetchurl {
      url = versions.kubesess.url;
      sha256 = versions.kubesess.sha;
    };

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
    version = versions.xmlformatter.version;
    src = fetchurl {
      url = versions.xmlformatter.url;
      sha256 = versions.xmlformatter.sha;
    };
  };

  cqlsh = python3Packages.buildPythonPackage rec {
    pname = "cqlsh";
    version = versions.cqlsh.version;
    src = fetchurl {
      url = versions.cqlsh.url;
      sha256 = versions.cqlsh.sha;
    };

    propagatedBuildInputs = with python310Packages; [
      cassandra-driver
      # six
      # cql
    ];
  };

  wutag = stdenv.mkDerivation rec {
    pname = "wutag";
    version = versions.wutag.version;
    src = fetchurl {
      url = versions.wutag.url;
      sha256 = versions.wutag.sha;
    };

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
    version = versions.sheldon.version;
    src = fetchurl {
      url = versions.sheldon.url;
      sha256 = versions.sheldon.sha;
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

    meta = {
      homepage = "https://github.com/rossmacarthur/sheldon";
      description = "Fast, configurable, shell plugin manager";
    };
  };

  dtool = rustPlatform.buildRustPackage rec {
    pname = "dtool";
    version = versions.dtool.version;
    src = fetchFromGitHub {
      owner = "guoxbin";
      repo = "dtool";
      rev = "v${version}";
      sha256 = versions.dtool.sha;
    };
    cargoSha256 = "sha256-r8r3f4yKMQgjtB3j4qE7cqQL18nIqAGPO5RsFErqh2c=";

    nativeBuildInputs = [pkg-config];
    buildInputs = [bzip2 xz zlib];

    meta = {
      homepage = "https://github.com/guoxbin/dtool";
      description = "CLI tool collection to assist development";
    };
  };

  ytui-music = stdenv.mkDerivation rec {
    pname = "ytui-music";
    version = versions.ytui-music.version;
    src = fetchurl {
      url = versions.ytui-music.url;
      sha256 = versions.ytui-music.sha;
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
    version = versions.go-commitlinter.version;
    src = fetchurl {
      url = versions.go-commitlinter.url;
      sha256 = versions.go-commitlinter.sha;
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
    version = versions.csvlens.version;
    src = fetchFromGitHub {
      owner = "YS-L";
      repo = "csvlens";
      rev = "v${version}";
      sha256 = versions.csvlens.sha;
    };
    cargoSha256 = "sha256-cYm9z6K2fSIKcHxFb7rhudsMkKb4jhi2jwocNTouCmM=";

    nativeBuildInputs = [pkg-config];
    buildInputs = [bzip2 xz zlib zstd];

    meta = {
      homepage = "https://github.com/YS-L/csvlens";
      description = "Command line csv viewer";
    };
  };

  mailctl = stdenv.mkDerivation rec {
    pname = "mailctl";
    version = versions.mailctl.version;
    src = fetchurl {
      url = versions.mailctl.url;
      sha256 = versions.mailctl.sha;
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
    version = versions.youtube-tui.version;
    src = fetchurl {
      url = versions.youtube-tui.url;
      sha256 = versions.youtube-tui.sha;
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
    version = versions.shellcaster.version;
    src = fetchurl {
      url = versions.shellcaster.url;
      sha256 = versions.shellcaster.sha;
    };

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
    version = versions.klog.version;
    src = fetchzip {
      url = versions.klog.url;
      sha256 = versions.klog.sha;
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
    version = versions.versio.version;
    src = fetchurl {
      url = versions.versio.url;
      sha256 = versions.versio.sha;
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
    version = versions.focus.version;
    src = fetchurl {
      url = versions.focus.url;
      sha256 = versions.focus.sha;
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

  gup = stdenv.mkDerivation rec {
    pname = "gup";
    version = versions.gup.version;
    src = fetchurl {
      url = versions.gup.url;
      sha256 = versions.gup.sha;
    };

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
    version = versions.kubeshark.version;
    src = fetchurl {
      url = versions.kubeshark.url;
      sha256 = versions.kubeshark.sha;
    };

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
    version = versions.sttr.version;
    src = fetchurl {
      url = versions.sttr.url;
      sha256 = versions.sttr.sha;
    };

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
    version = versions.termshot.version;
    src = fetchurl {
      url = versions.termshot.url;
      sha256 = versions.termshot.sha;
    };

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
    version = versions.riff.version;
    src = fetchurl {
      url = versions.riff.url;
      sha256 = versions.riff.sha;
    };

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
    version = versions.aiac.version;
    src = fetchurl {
      url = versions.aiac.url;
      sha256 = versions.aiac.sha;
    };

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
    pname = "updatecli";
    version = versions.updatecli.version;
    src = fetchurl {
      url = versions.updatecli.url;
      sha256 = versions.updatecli.sha;
    };

    sourceRoot = ".";
    installPhase = ''
      install -m755 -D updatecli $out/bin/updatecli
    '';

    meta = {
      homepage = "https://github.com/updatecli/updatecli";
      description = "A Declarative Dependency Management tool";
    };
  };

  got = stdenv.mkDerivation rec {
    pname = "got";
    version = versions.got.version;
    src = fetchurl {
      url = versions.got.url;
      sha256 = versions.got.sha;
    };

    sourceRoot = ".";
    installPhase = ''
      install -m755 -D got $out/bin/got
    '';

    meta = {
      homepage = "https://github.com/updatecli/updatecli";
      description = "A Declarative Dependency Management tool";
    };
  };

  sane-scan-pdf = stdenv.mkDerivation rec {
    pname = "sane-scan-pdf";
    version = versions.sane-scan-pdf.version;
    src = fetchFromGitHub {
      owner = "rocketraman";
      repo = "sane-scan-pdf";
      rev = "v${version}";
      sha256 = versions.sane-scan-pdf.sha;
    };

    # sourceRoot = ".";
    installPhase = ''
      install -m755 -D scan $out/bin/scan
      install -m755 -D scan_perpage $out/bin/scan_perpage
    '';

    meta = {
      homepage = "https://github.com/rocketraman/sane-scan-pdf";
      description = "Sane command-line scan-to-pdf script on Linux with OCR and deskew support";
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
  sane-scan-pdf = sane-scan-pdf;
  got = got;
}
