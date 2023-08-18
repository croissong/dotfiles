let
  versions = builtins.fromJSON (builtins.readFile ./versions.json);
in [
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

  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/development/tools/kubeswitch/default.nix
  (self: super: {
    kubeswitch = super.kubeswitch.overrideAttrs (prev: rec {
      version = "0.8.0";
      src = super.fetchFromGitHub {
        rev = version;
        sha256 = "sha256-7BQhkFvOgmLuzBEvAou8KANhxWna5KVokIF4DEIVU2g=";
        repo = super.kubeswitch.pname;
        owner = "danielfoehrKn";
      };

      ldflags = [
        "-s"
        "-w"
        "-X github.com/danielfoehrkn/kubeswitch/cmd/switcher.version=${version}"
        "-X github.com/danielfoehrkn/kubeswitch/cmd/switcher.buildDate=1970-01-01"
      ];

      nativeBuildInputs = prev.nativeBuildInputs ++ [super.installShellFiles];

      postInstall = ''
        mv $out/bin/main $out/bin/switcher
        mkdir $out/share
        $out/bin/switcher init zsh > $out/share/switch.zsh
        installShellCompletion --cmd switch --zsh <($out/bin/switcher completion --cmd switch zsh)
      '';

      doCheck = false;
    });
  })

  (self: super: {
    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/networking/sync/rclone/default.nix
    rclone = let
      version = "1.63.1-next";
      src = super.fetchFromGitLab {
        rev = "40de89df73cf26424fdc2a5676f36eefe9d9dc43";
        hash = "sha256-uS1kSgS8jyHiamfI/t/yT43mneSbSkbj4csIJEWX6Dc=";
        repo = super.rclone.pname;
        owner = super.rclone.pname;
      };
    in (super.rclone.override {
      buildGoModule = args:
        super.buildGoModule (args
          // {
            vendorHash = "sha256-FGsYzmNGI8dUwLJfthPDHH1EuWLze5szR1P1ySmMyJI=";
            ldflags = ["-s" "-w" "-X github.com/rclone/rclone/fs.Version=${version}"];
            doCheck = false;
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
