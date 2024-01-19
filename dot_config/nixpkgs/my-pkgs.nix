{
  lib,
  pkgs,
  versions,
  ...
}:
with pkgs; let
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

    installPhase = ''
      install -m755 -D scan $out/bin/scan
      install -m755 -D scan_perpage $out/bin/scan_perpage
    '';

    meta = {
      homepage = "https://github.com/rocketraman/sane-scan-pdf";
      description = "Sane command-line scan-to-pdf script on Linux with OCR and deskew support";
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
    propagatedBuildInputs = with python311Packages; [antlr4-python3-runtime];

    meta = {
      homepage = "https://github.com/facetoe/promformat";
      description = "PromQL formatter";
    };
  };

  commitlint-rs = rustPlatform.buildRustPackage rec {
    pname = "commitlint-rs";
    version = versions.commitlint-rs.version;
    src = fetchFromGitHub {
      owner = "KeisukeYamashita";
      repo = "commitlint-rs";
      rev = "v${version}";
      sha256 = versions.commitlint-rs.sha;
    };
    cargoSha256 = "sha256-ZskWIoSaNww9gv8CPjS+v4FhFOjHiS+HDKTFc8WYUxw=";

    meta = {
      homepage = "https://github.com/KeisukeYamashita/commitlint-rs";
      description = "Lint commit messages with conventional commit messages ";
    };
  };
in {
  cqlsh = cqlsh;
  desed = desed;
  focus = focus;
  commitlint-rs = commitlint-rs;
  got = got;
  kanri = kanri;
  promformat = promformat;
  protocurl = protocurl;
  qsv = qsv;
  gtrash = gtrash;
  sane-scan-pdf = sane-scan-pdf;
  sttr = sttr;
  updatecli = updatecli;
  wutag = wutag;
  xmlformatter = xmlformatter;
}
