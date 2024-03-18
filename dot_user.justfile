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

nix: nix-os nix-hm


nix-hm update='true':
  nh home switch {{ if update == "true" {"--update"} else {""} }} -c moi@bon  -- --impure

nix-os update='true':
  nh os switch {{ if update == "true" {"--update"} else {""} }} -- --impure


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
