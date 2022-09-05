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
  home-manager generations | head -n2 | choose 4 | sd -f m '^(.*)\n(.*)$' 'nvd diff /nix/var/nix/profiles/per-user/croissong/home-manager-{$2,$1}-link' | bash



gc:
  podman system prune --all --force && podman rmi --all
  nix-collect-garbage
