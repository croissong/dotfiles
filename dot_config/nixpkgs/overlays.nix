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
]
