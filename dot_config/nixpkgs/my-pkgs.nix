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
    version = "1.2.3";

    src = pkgs.fetchurl {
      url = "https://github.com/Ramilito/kubesess/releases/download/${version}/kubesess_${version}_x86_64-unknown-linux-gnu.tar.gz";
      sha256 = "sha256-LByeD2pF4vpHYt6xdGZDtIWTV5asTdHLqw8DIOCi5X0=";
    };

    phases = ["installPhase"];
    installPhase = ''
      mkdir -p $out/tar
      tar zxpf $src -C $out/tar &&
      mkdir -p $out/bin
      cp $out/tar/target/x86_64-unknown-linux-gnu/release/kubesess $out/bin/kubesess
    '';
  };
in {
  xdg-ninja = xdg-ninja;
  kubesess = kubesess;
}
