[
  (self: super: {
    mako = super.mako.overrideAttrs (prev: rec {
      version = "0d95a1653616454e894f27edc329a9f3a7f96dc2";
      src = super.fetchFromGitHub {
        owner = "emersion";
        repo = super.mako.pname;
        rev = "0d95a1653616454e894f27edc329a9f3a7f96dc2";
        sha256 = "sha256-06UDXVsC7jDd/Lq7dSu3ZnkGW9rLiGHSJLoG9SZi1HY=";
      };
    });
  })

  (self: super: {
    summon = let
      version = "0.9.3";
      src = super.fetchFromGitHub {
        owner = "cyberark";
        repo = "summon";
        rev = "v${version}";
        sha256 = "sha256-3JhQii+G/dGPu6hNzB+/h+udN31YeMQV8anzCXKJVKQ=";
      };
    in (super.summon.override rec {
      buildGoModule = args:
        super.buildGoModule (args
          // {
            vendorSha256 = "sha256-dm5z69dE95ANp7NWL7zlGMMZ11KPB4NzcSbrr4OcJDo=";
            inherit src version;
            patches = [];
          });
    });
  })

  (self: super: {
    mani = let
      version = "0.21.0";
      src = super.fetchFromGitHub {
        owner = "alajmo";
        repo = "mani";
        rev = "v${version}";
        sha256 = "sha256-eH6V7J0KHGyR//kVr0dOdBYuoR3FDbW/pSh0RhHd4A8=";
      };
    in (super.mani.override rec {
      buildGoModule = args:
        super.buildGoModule (args
          // {
            vendorSha256 = "sha256-g336is8Jjbbzmtsu3suhO9SNq3IJyy1MQ3s8P39MhvU=";
            inherit src version;
          });
    });
  })

  (self: super: {
    # https://github.com/NixOS/nixpkgs/issues/107070
    ouch =
      super.rustPlatform.buildRustPackage
      rec {
        pname = "ouch";
        version = "0.3.1-next";

        src = super.fetchFromGitHub {
          owner = "ouch-org";
          repo = pname;
          rev = "fc532d81d8136cc69eb73bdf3c3d65faede7a596";
          sha256 = "sha256-Qj2CvplJBfgrAep4ivVXiNKDQN2S4R1hdlqZ4S2+MnY=";
        };

        cargoSha256 = "sha256-Qj2CvplJBfgrAep4ivVXiNKDQN2S4R1hdlqZ4S2+MnR=";
        cargoHash = "sha256-RsvpFrwX7QhKpOevH9OnG/E0vRbBpSWLO2j6NUVT/Sg=";

        nativeBuildInputs = [super.help2man super.installShellFiles super.pkg-config];

        buildInputs = [super.bzip2 super.xz super.zlib super.zstd];

        buildFeatures = ["zstd/pkg-config"];

        postInstall = ''
          help2man $out/bin/ouch > ouch.1
          installManPage ouch.1

          completions=($releaseDir/build/ouch-*/out/completions)
          installShellCompletion $completions/ouch.{bash,fish} --zsh $completions/_ouch
        '';

        GEN_COMPLETIONS = 1;

        meta = with super.lib; {
          description = "A command-line utility for easily compressing and decompressing files and directories";
          homepage = "https://github.com/ouch-org/ouch";
          license = licenses.mit;
          maintainers = with maintainers; [figsoda psibi];
        };
      };
  })
]
