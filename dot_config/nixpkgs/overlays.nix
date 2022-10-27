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
      version = "0.147.0";
      src = super.fetchFromGitHub {
        owner = "helmfile";
        repo = super.helmfile.pname;
        rev = "v0.147.0";
        sha256 = "sha256-W6xkLqH0wHvCmwzwQyXpRbcj/itm3leRMFGa5RIYJ4A=";
      };
    in (super.helmfile.override rec {
      buildGoModule = args:
        super.buildGoModule (args
          // {
            vendorSha256 = "sha256-77dedk8QG3KNQX21IbA9HuJPRgNwgwqhmZvViRnxJHw=";
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
]
