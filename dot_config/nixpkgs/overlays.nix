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
    in (super.summon.override {
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
    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/networking/cluster/helmfile/default.nix
    helmfile = let
      versions = builtins.fromJSON (builtins.readFile (./. + "/versions.json"));

      version = versions.helmfile.version;
      src = super.fetchFromGitHub {
        owner = "helmfile";
        repo = "helmfile";
        rev = "v${version}";
        sha256 = versions.helmfile.sha;
      };
    in (super.helmfile.override {
      buildGoModule = args:
        super.buildGoModule (args
          // {
            vendorSha256 = "sha256-akxA1AeYuaIKBAgt+u5fWcFYYP1YVMT79l5WwTn1bnI=";
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
]
