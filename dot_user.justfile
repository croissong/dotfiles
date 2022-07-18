vpnio-start:
    systemctl restart strongswan
    sudo swanctl -i -c vpn
vpnio-stop:
    systemctl stop strongswan



nix-hm:
  chezmoi apply ~/.config/nixpkgs
  nix-collect-garbage
  cd ~/.config/nixpkgs && nix --extra-experimental-features "nix-command flakes" flake update
  NIXPKGS_ALLOW_UNFREE=1 home-manager --extra-experimental-features "nix-command flakes" --impure switch --flake ~/.config/nixpkgs#moi
