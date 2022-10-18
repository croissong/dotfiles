vpnio-start:
    systemctl restart strongswan
    sudo swanctl -i -c vpn
vpnio-stop:
    systemctl stop strongswan


nix: nix-hm nix-diff

nix-hm:
  chezmoi apply ~/.config/nixpkgs
  cd ~/.config/nixpkgs && nix --extra-experimental-features "nix-command flakes" flake update
  NIXPKGS_ALLOW_UNFREE=1 home-manager --extra-experimental-features "nix-command flakes" --impure switch --flake ~/.config/nixpkgs#moi


nix-diff:
  # https://discourse.nixos.org/t/nvd-simple-nix-nixos-version-diff-tool/12397/28
  nix --extra-experimental-features "nix-command flakes" store diff-closures $(\ls -dv /nix/var/nix/profiles/per-user/croissong/home-manager-*-link | /usr/bin/tail -2)



gc:
  podman system prune --all --force && podman rmi --all
  nix-collect-garbage -d
