let
  versions = builtins.fromJSON (builtins.readFile ./versions.json);
in [
  (self: super: {
    # https://github.com/NixOS/nixpkgs/blob/nixpkgs-unstable/pkgs/development/tools/go-mockery/default.nix
    go-mockery = let
      version = "2.28.1";
      src = super.fetchFromGitHub {
        owner = "vektra";
        repo = "mockery";
        rev = "v${version}";
        sha256 = "sha256-TPFrpBwD7r04k4qtyhtRYSXFukfi14TYDHsD57Q0+MQ=";
      };
    in (super.go-mockery.override {
      buildGoModule = args:
        super.buildGoModule (args
          // {
            vendorHash = "sha256-c8HsrcS3x16x3x/VQjQ2XWxfMVYHJ6pbQWztqFj0ju4=";
            proxyVendor = true;
            ldflags = [
              "-s"
              "-w"
              "-X"
              "github.com/vektra/mockery/v2/pkg/logging.SemVer=v${version}"
            ];
            preCheck = ''
              substituteInPlace ./pkg/generator_test.go --replace 0.0.0-dev ${version}
            '';
            inherit src version;
          });
    });
  })

  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/misc/termdown/default.nix
  (self: super: {
    termdown = super.termdown.overrideAttrs (prev: rec {
      version = "1.18.0";
      src = super.fetchFromGitHub {
        rev = version;
        sha256 = "sha256-Hnk/MOYdbOl14fI0EFbIq7Hmc7TyhcZWGEg2/jmNJ5Y=";
        repo = "termdown";
        owner = "trehn";
      };
    });
  })

  (self: super: {
    cyrus-sasl-xoauth2 = super.pkgs.stdenv.mkDerivation {
      pname = "cyrus-sasl-xoauth2";
      version = "master";

      src = super.pkgs.fetchFromGitHub {
        owner = "moriyoshi";
        repo = "cyrus-sasl-xoauth2";
        rev = "master";
        sha256 = "sha256-OlmHuME9idC0fWMzT4kY+YQ43GGch53snDq3w5v/cgk=";
      };

      nativeBuildInputs = [super.pkg-config super.automake super.autoconf super.libtool];
      propagatedBuildInputs = [super.cyrus_sasl];

      buildPhase = ''
        ./autogen.sh
        ./configure
      '';

      installPhase = ''
        make DESTDIR="$out" install
      '';

      meta = {
        homepage = "https://github.com/moriyoshi/cyrus-sasl-xoauth2";
        description = "XOAUTH2 mechanism plugin for cyrus-sasl";
      };
    };

    # https://github.com/NixOS/nixpkgs/issues/108480#issuecomment-1115108802
    isync-oauth2 = super.buildEnv {
      name = "isync-oauth2";
      paths = [super.isync];
      pathsToLink = ["/bin"];
      nativeBuildInputs = [super.makeWrapper];
      postBuild = ''
        wrapProgram "$out/bin/mbsync" \
          --prefix SASL_PATH : "${super.cyrus_sasl.out.outPath}/lib/sasl2:${self.cyrus-sasl-xoauth2}/usr/lib/sasl2"
      '';
    };
  })

  (self: super: {
    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/tools/networking/goimapnotify/default.nix
    goimapnotify = let
      version = "2.4-rc3";
      src = super.fetchFromGitLab {
        owner = "shackra";
        repo = "goimapnotify";
        rev = version;
        sha256 = "sha256-tu2fUPBOJcWiYLmxEjRjdRdS9i+Rl9icQVb90kEXYTY=";
      };
    in (super.goimapnotify.override {
      buildGoModule = args:
        super.buildGoModule (args
          // {
            vendorSha256 = "sha256-DphGe9jbKo1aIfpF5kRYNSn/uIYHaRMrygda5t46svw=";
            inherit src version;
          });
    });
  })

  (self: super: {
    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/tools/security/tessen/default.nix
    tessen = super.tessen.overrideAttrs (prev: {
      version = "2.2.1-next";
      dontUnpack = true;
      src = /home/croissong/code/forks/tessen;
      installPhase = ''
        runHook preInstall
        install -D $src/tessen $out/bin/tessen
      '';
    });
  })

  # (self: super: {
  #   # https://github.com/NixOS/nixpkgs/blob/master/pkgs/tools/networking/telepresence2/default.nix
  #   telepresence2 = let
  #     version = versions.telepresence.version;
  #     src = super.fetchFromGitHub {
  #       owner = "telepresenceio";
  #       repo = "telepresence";
  #       rev = "v${version}";
  #       sha256 = versions.telepresence.sha;
  #     };
  #   in (super.telepresence2.override {
  #     buildGoModule = args:
  #       super.buildGoModule (args
  #         // {
  #           vendorSha256 = "sha256-G5brVbIFMoE89xz13snpO291fMa2ic3zZaIEGfB1AV4=";
  #           inherit src version;
  #           preBuild = "";
  #         });
  #   });
  # })
]
