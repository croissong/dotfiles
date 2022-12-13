default:
  @just --choose


vpnio-start:
    systemctl restart strongswan
    sudo swanctl -i -c vpn
vpnio-stop:
    systemctl stop strongswan


nix: nix-nv nix-hm nix-diff

nix-hm:
  #!/usr/bin/env bash
  cd ~/Dotfiles/dot_config/nixpkgs/
  chezmoi apply ~/.config/nixpkgs
  NIXPKGS_ALLOW_UNFREE=1 home-manager --impure switch \
  --flake ~/.config/nixpkgs#moi \
  --update-input nixpkgs \
  --update-input home-manager \
  --update-input nixpkgs-stable
  # --update-input nixpkgs-master \


nix-diff:
  # https://discourse.nixos.org/t/nvd-simple-nix-nixos-version-diff-tool/12397/28
  nix store diff-closures $(\ls -dv /nix/var/nix/profiles/per-user/croissong/home-manager-*-link | /usr/bin/tail -2)


nix-nv:
 #!/usr/bin/env bash
 cd ~/Dotfiles/dot_config/nixpkgs/
 nix run git+https://github.com/berberman/nvfetcher -- \
   --keyfile ~/.config/nvchecker/keyfile.toml

gc:
  podman system prune --all --force && podman rmi --all --force
  nix-collect-garbage -d
