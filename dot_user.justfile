vpnio-start:
    systemctl restart strongswan
    sudo swanctl -i -c vpn
vpnio-stop:
    systemctl stop strongswan



nix-hm:
  cm apply ~/.config/nixpkgs
  NIXPKGS_ALLOW_UNFREE=1 home-manager --impure --extra-experimental-features "nix-command flakes" switch --flake ~/.config/nixpkgs#moi
