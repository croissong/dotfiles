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
]
