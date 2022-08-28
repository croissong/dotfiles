[

  (self: super: {
    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/tools/networking/bukubrow/default.nix
    bukubrow = let
      version = "5.4.0";
      src = super.fetchFromGitHub {
        owner = "SamHH";
        repo = super.bukubrow.pname;
        rev = "v${version}";
        sha256 = "1a3gqxj6d1shv3w0v9m8x2xr0bvcynchy778yqalxkc3x4vr0nbn";
      };
    in (super.bukubrow.override rec {
      rustPlatform.buildRustPackage = args:
        super.rustPlatform.buildRustPackage (args
          // {
            cargoSha256 = "sha256-CuCiygdBBCmsQ4ZPa8vH6aSxj0+lrh01aHQ6blq9Zg8=";
            inherit src version;
            patches = [];
          });
    });
  })

  (self: super: {
    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/development/tools/summon/default.nix
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
    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/tools/networking/bukubrow/default.nix
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
    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/networking/cluster/kubelogin/default.nix
    kubelogin = let
      version = "0.0.20";
      src = super.fetchFromGitHub {
        owner = "Azure";
        repo = super.kubelogin.pname;
        rev = "v${version}";
        sha256 = "sha256-+u+75Z2Efaq16g7kGNq1GHavXwtKvNO6dytniUr8mlE=";
      };
    in (super.kubelogin.override rec {
      buildGoModule = args:
        super.buildGoModule (args
          // {
            vendorSha256 = "sha256-vJfTf9gD/qrsPAfJeMYLjGa90mYLOshgDehv2Fcl6xM=";
            inherit src version;
            patches = [];
          });
    });
  })
]
