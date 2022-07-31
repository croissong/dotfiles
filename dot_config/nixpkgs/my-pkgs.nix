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

    phases = ["installPhase" "patchPhase"];
    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/xdg-ninja
      chmod +x $out/bin/xdg-ninja
    '';
  };
in {xdg-ninja = xdg-ninja;}
