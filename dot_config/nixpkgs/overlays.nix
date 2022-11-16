[
  (self: super: {
    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/development/tools/summon/default.nix
    summon = let
      version = "0.9.4";
      src = super.fetchFromGitHub {
        owner = "cyberark";
        repo = "summon";
        rev = "v${version}";
        sha256 = "sha256-j+3gnrjcMEk5phF0SivjBZBeK7xWjzkAyy4SD3cHDUg=";
      };
    in (super.summon.override rec {
      buildGoModule = args:
        super.buildGoModule (args
          // {
            vendorSha256 = "sha256-ofBqcD/WsUi0XSKydITttsOQja46bQG3Rn1pgsh1b9k=";
            inherit src version;
            patches = [];
          });
    });
  })

  (self: super: {
    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/tools/compression/ouch/default.nix
    ouch = let
      version = "0.3.1-next";
      src = super.fetchFromGitHub {
        owner = "ouch-org";
        repo = super.ouch.pname;
        rev = "99ec7d2cf2a929554a3520e393dd80d087935278";
        sha256 = "sha256-nBDCAb8y8tz4VM7eC+AdF0N2cwoJ/GwqiOo8RhUQs4w=";
      };
    in (super.ouch.override rec {
      rustPlatform.buildRustPackage = args:
        super.rustPlatform.buildRustPackage (args
          // {
            cargoSha256 = "sha256-RsvpFrwX7QhKpOevH9OnG/E0vRbBpSWLO2j6NUVT/Sg=";
            inherit src version;
            patches = [];
          });
    });
  })

  (self: super: {
    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/networking/cluster/helmfile/default.nix
    helmfile = let
      version = "0.148.1";
      src = super.fetchFromGitHub {
        owner = "helmfile";
        repo = super.helmfile.pname;
        rev = "v${version}";
        sha256 = "sha256-Nvf26ahWc1fCWngroc+5gPV1T5UBa/6ix/I9tdQ01t8=";
      };
    in (super.helmfile.override rec {
      buildGoModule = args:
        super.buildGoModule (args
          // {
            vendorSha256 = "sha256-hwJ3vVbGE7L+mkjDzxy6xDT9hjA5cIwxQsHaJpozwvE=";
            inherit src version;

            ldflags = ["-s" "-w" "-X go.szostok.io/version.version=${version}"];

            postInstall = ''
              installShellCompletion --cmd helmfile \
                --bash <($out/bin/helmfile completion --bash) \
                --zsh <($out/bin/helmfile completion --zsh)
            '';
          });
    });
  })

  (self: super: {
    cyrus-sasl-xoauth2 = super.pkgs.stdenv.mkDerivation rec {
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

      meta = with super.pkgs.lib; {
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
    # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/applications/networking/instant-messengers/twitch-tui/default.nix#L27
    twitch-tui = let
      version = "2.0.0-rc.1";
      src = super.fetchFromGitHub {
        owner = "Xithrius";
        repo = super.twitch-tui.pname;
        rev = "184564cd855858c18c11756ef1c510f9c22d7471";
        sha256 = "sha256-lxcusriUjG4Ww+oLuQbuZugCOWUB3xNi8wzs/XqvTVc=";
      };
    in (super.twitch-tui.override rec {
      rustPlatform.buildRustPackage = args:
        super.rustPlatform.buildRustPackage (args
          // {
            cargoHash = "sha256-TIVy6DjVQfZG8w+4TF/d+IS2PzBj4FX0PKfyatWaop4=";
            nativeBuildInputs = [super.pkgs.pkg-config super.pkgs.zstd];
            inherit src version;
          });
    });
  })
]
