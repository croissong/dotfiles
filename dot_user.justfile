import 'dot/priv/justfile'


# https://github.com/casey/just/issues/1557
# default:
#   @just --justfile {{justfile()}} --choose

vpn-start:
  systemctl restart strongswan-swanctl
  sudo swanctl -i -c vpn-wrk
vpn-stop:
  sudo swanctl -t -c vpn-wrk
  systemctl stop strongswan-swanctl

nix: nix-os  nix-hm


nix-hm update='true': && nix-hm-diff
  {{ if update == "true" {"nix flake update --impure --flake $DOT/system/nix-config"} else {""} }}
  home-manager switch --impure \
    --flake path://$DOT/system/nix-config#moi@bon

nix-os update='true': && nix-os-diff
  {{ if update == "true" {"nix flake update --impure --flake $DOT/system/nix-config"} else {""} }}
  sudo nixos-rebuild switch --impure \
    --flake path://$DOT/system/nix-config#bon

nix-os-diff:
  nix store diff-closures $(ls -dv /nix/var/nix/profiles/system-*-link | tail -2) | rg → | moar

nix-hm-diff:
  nix store diff-closures $(ls -dv ~/.local/state/nix/profiles/home-manager-*-link | tail -2) | rg → | moar


netd-restart:
  systemctl stop strongswan-swanctl
  systemctl restart systemd-networkd dnscrypt-proxy2 iwd

netd-journal:
  journalctl -u systemd-networkd -u dnscrypt-proxy2 -u iwd

gc:
  podman system prune --all --force && podman rmi --all --force
  nix-collect-garbage -d


scan out:
  systemctl restart avahi-daemon.service
  # scanadf -L
  scan --verbose --mode Color --resolution 600 -e 1 --no-default-size \
    -x 'airscan:e0:Canon TS5000 series' \
    --unpaper --ocr \
    -o {{out}}.pdf


updatecli:
  @just --justfile $DOT/dotfiles/dot_config/updatecli/justfile -d $DOT/dotfiles/dot_config/updatecli apply

grm:
  grm repos sync config --config ~/.config/git-repo-manager/config.yaml
