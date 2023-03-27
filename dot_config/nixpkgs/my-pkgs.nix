{
  pkgs,
  config,
  versions,
  ...
}:
with pkgs; let
  ata = stdenv.mkDerivation {
    pname = "ata";
    version = versions.ata.version;
    src = fetchurl {
      url = versions.ata.url;
      sha256 = versions.ata.sha;
    };

    unpackPhase = ":";
    installPhase = ''
      install -m755 -D $src $out/bin/ata
    '';

    meta = {
      homepage = "https://github.com/rikhuijzer/ata";
      description = "OpenAI GPT in the terminal";
    };
  };

  cqlsh = python3Packages.buildPythonPackage {
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

  csvlens = rustPlatform.buildRustPackage rec {
    pname = "csvlens";
    version = versions.csvlens.version;
    src = fetchFromGitHub {
      owner = "YS-L";
      repo = "csvlens";
      rev = "v${version}";
      sha256 = versions.csvlens.sha;
    };
    cargoSha256 = "sha256-Onb8pyl3U/EaJ/J/yZn1jGvUZWms/mJVFilWA4rmKCE=";

    nativeBuildInputs = [pkg-config];
    buildInputs = [bzip2 xz zlib zstd];

    meta = {
      homepage = "https://github.com/YS-L/csvlens";
      description = "Command line csv viewer";
    };
  };

  desed = stdenv.mkDerivation {
    pname = "desed";
    version = versions.desed.version;
    src = fetchurl {
      url = versions.desed.url;
      sha256 = versions.desed.sha;
    };

    unpackPhase = ":";
    installPhase = ''
      install -m755 -D $src $out/bin/desed
    '';

    meta = {
      homepage = "https://github.com/SoptikHa2/desed";
      description = "Debugger for Sed: demystify and debug your sed scripts";
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

  focus = stdenv.mkDerivation {
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

  go-commitlinter = stdenv.mkDerivation {
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

  got = stdenv.mkDerivation {
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

  gup = stdenv.mkDerivation {
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

  klog = stdenv.mkDerivation {
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

  mailctl = stdenv.mkDerivation rec {
    pname = "mailctl";
    version = versions.mailctl.version;
    src = fetchurl {
      url = versions.mailctl.url;
      sha256 = versions.mailctl.sha;
    };

    installPhase = ''
      install -m755 -D mailctl-${version}-Linux-x86_64 $out/bin/mailctl
    '';

    meta = {
      homepage = "https://github.com/pdobsan/mailctl";
      description = "Provide IMAP/SMTP clients with the capabilities of renewal and authorization of OAuth2 credentials";
    };
  };

  protocurl = stdenv.mkDerivation {
    pname = "protocurl";
    version = versions.protocurl.version;
    src = fetchzip {
      url = versions.protocurl.url;
      sha256 = versions.protocurl.sha;
      stripRoot = false;
    };

    installPhase = ''
      install -m755 -D bin/protocurl $out/bin/protocurl
    '';

    meta = {
      homepage = "https://github.com/qaware/protocurl";
      description = "cURL for Protobuf";
    };
  };

  qsv = stdenv.mkDerivation {
    pname = "qsv";
    version = versions.qsv.version;
    src = fetchzip {
      url = versions.qsv.url;
      sha256 = versions.qsv.sha;
      stripRoot = false;
    };

    installPhase = ''
      install -m755 -D qsv $out/bin/qsv
    '';

    meta = {
      homepage = "https://github.com/jqnatividad/qsv";
      description = "CSVs sliced, diced & analyzed";
    };
  };

  riff = stdenv.mkDerivation {
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

  # TODO: https://github.com/NixOS/nixpkgs/blob/master/pkgs/tools/misc/sheldon/default.nix
  sheldon = stdenv.mkDerivation {
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

  shellcaster = stdenv.mkDerivation {
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

  sttr = stdenv.mkDerivation {
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

  termshot = stdenv.mkDerivation {
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

  updatecli = stdenv.mkDerivation {
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

  versio = stdenv.mkDerivation {
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

  wutag = stdenv.mkDerivation {
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

  xmlformatter = python3Packages.buildPythonPackage {
    pname = "xmlformatter";
    version = versions.xmlformatter.version;
    src = fetchurl {
      url = versions.xmlformatter.url;
      sha256 = versions.xmlformatter.sha;
    };
  };

  ytui-music = stdenv.mkDerivation {
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

  kanri = pkgs.appimageTools.wrapType2 rec {
    pname = "kanri";
    version = "0.3.3";

    src = fetchurl {
      url = "https://github.com/trobonox/kanri/releases/download/app-v0.3.3/kanri_0.3.3_amd64.AppImage";
      hash = "sha256-gyRjDPPLhBHufSZZPNyEKmGwKziai1TW6B5ui63xB1E=";
    };

    # TODO: many examples https://github.com/NixOS/nixpkgs/search?q=appimageTools&type=issues
    # kanri-desktop = writeTextDir "share/applications/kanri.desktop" ''
    #   [Desktop Entry]
    #   Version=3
    #   Type=Application
    #   Name=Kanri
    #   Exec=kanri
    # '';

    # TODO: https://github.com/NixOS/nixpkgs/issues/200955
    extraPkgs = pkgs: with pkgs; [libthai];

    extraInstallCommands = ''
      mv $out/bin/kanri-${version} $out/bin/kanri
    '';

    meta = {
      homepage = "https://github.com/trobonox/kanri";
      description = "Kanban board desktop application";
    };
  };

  promformat = python3Packages.buildPythonPackage {
    pname = "promformat";
    format = "wheel";
    version = versions.promformat.version;
    src = fetchurl {
      url = versions.promformat.url;
      sha256 = versions.promformat.sha;
    };
    propagatedBuildInputs = with python310Packages; [antlr4-python3-runtime];

    meta = {
      homepage = "https://github.com/facetoe/promformat";
      description = "PromQL formatter";
    };
  };
in {
  ata = ata;
  cqlsh = cqlsh;
  csvlens = csvlens;
  desed = desed;
  dtool = dtool;
  focus = focus;
  go-commitlinter = go-commitlinter;
  got = got;
  gup = gup;
  kanri = kanri;
  klog = klog;
  kubesess = kubesess;
  mailctl = mailctl;
  promformat = promformat;
  protocurl = protocurl;
  qsv = qsv;
  riff = riff;
  sane-scan-pdf = sane-scan-pdf;
  sheldon = sheldon;
  shellcaster = shellcaster;
  sttr = sttr;
  termshot = termshot;
  updatecli = updatecli;
  versio = versio;
  wutag = wutag;
  xmlformatter = xmlformatter;
  youtube-tui = youtube-tui;
  ytui-music = ytui-music;
}
