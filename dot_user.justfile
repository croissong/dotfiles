default:
  @just --choose


vpnio-start:
    systemctl restart strongswan
    sudo swanctl -i -c vpn
vpnio-stop:
    systemctl stop strongswan


nix: nix-nv nix-hm nix-diff

nix-hm:
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
 nvfetcher

gc:
  podman system prune --all --force && podman rmi --all --force
  nix-collect-garbage -d
