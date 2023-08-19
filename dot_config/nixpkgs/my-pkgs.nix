{
  pkgs,
  versions,
  ...
}:
with pkgs; let
  ain = stdenv.mkDerivation {
    pname = "ain";
    version = versions.ain.version;
    src = fetchurl {
      url = versions.ain.url;
      sha256 = versions.ain.sha;
    };

    installPhase = ''
      install -m755 -D ain $out/bin/ain
    '';

    meta = {
      homepage = "https://github.com/jonaslu/ain";
      description = "A HTTP API client for the terminal";
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
    cargoSha256 = "sha256-DjxneZ65gSG0KrzF1e3A3/caa3t8dxABZE0QxsKXGUE=";

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

    dontUnpack = true;
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

  handlr-regex = stdenv.mkDerivation {
    pname = "handlr-regex";
    version = "0.8.4";
    src = fetchurl {
      url = "https://github.com/Anomalocaridid/handlr-regex/releases/download/v0.8.4/handlr";
      sha256 = "sha256-b4GwJ7hoaOYDlQ90u08WsEG7eP/VMTqXbD58k94XLUk=";
    };

    dontUnpack = true;
    installPhase = ''
      install -m755 -D $src $out/bin/handlr
    '';

    meta = {
      homepage = "https://github.com/Anomalocaridid/handlr-regex";
      description = "Fork of handlr with support for regex";
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
      description = "Creates screenshots based on terminal command output";
    };
  };

  tre = stdenv.mkDerivation {
    pname = "tre";
    version = versions.tre.version;
    src = fetchurl {
      url = versions.tre.url;
      sha256 = versions.tre.sha;
    };

    sourceRoot = ".";
    installPhase = ''
      install -m755 -D tre $out/bin/tre
    '';

    meta = {
      homepage = "https://github.com/dduan/tre";
      description = "Tree command, improved";
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

    dontUnpack = true;
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

    dontUnpack = true;
    installPhase = ''
      install -m755 -D $src $out/bin/ytui_music
    '';

    meta = {
      homepage = "https://github.com/sudipghimire533/ytui-music";
      description = "Youtube client in terminal for music";
    };
  };

  telepresence = stdenv.mkDerivation {
    pname = "telepresence";
    version = versions.telepresence.version;
    src = fetchurl {
      url = versions.telepresence.url;
      sha256 = versions.telepresence.sha;
    };

    dontUnpack = true;
    installPhase = ''
      install -m755 -D $src $out/bin/telepresence
    '';
  };

  rmt = stdenv.mkDerivation rec {
    pname = "rmt";
    version = "0.2.1";
    src = fetchurl {
      url = "https://github.com/AmineZouitine/rmt.rs/releases/download/${version}/rmt-x86_64-unknown-linux-gnu.tar.gz";
      sha256 = "sha256-DoBpWdLm6C1pcC65hZ+QMam7oY52moabMPXU5bU+ACI=";
    };

    sourceRoot = ".";
    installPhase = ''
      install -m755 -D rmt $out/bin/rmt
    '';
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
  ain = ain;
  ata = ata;
  cqlsh = cqlsh;
  csvlens = csvlens;
  desed = desed;
  dtool = dtool;
  focus = focus;
  go-commitlinter = go-commitlinter;
  got = got;
  handlr-regex = handlr-regex;
  kanri = kanri;
  klog = klog;
  promformat = promformat;
  protocurl = protocurl;
  qsv = qsv;
  rmt = rmt;
  sane-scan-pdf = sane-scan-pdf;
  shellcaster = shellcaster;
  sttr = sttr;
  telepresence = telepresence;
  termshot = termshot;
  tre = tre;
  updatecli = updatecli;
  versio = versio;
  wutag = wutag;
  xmlformatter = xmlformatter;
  youtube-tui = youtube-tui;
  ytui-music = ytui-music;
}
