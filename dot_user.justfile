import 'dot/priv/justfile'


# https://github.com/casey/just/issues/1557
# default:
#   @just --justfile {{justfile()}} --choose

vpnio-start:
  systemctl restart strongswan
  sudo swanctl -i -c vpn
vpnio-stop:
  systemctl stop strongswan

nix: nix-os  nix-hm nix-diff nix-check-missing

nix-hm *options:
  cd $DOT/system/nix-config
  nix flake update
  home-manager switch --impure --flake .#moi@bon {{options}}

nix-os *options:
  cd $DOT/system/nix-config
  nix flake update
  sudo nixos-rebuild switch --impure --flake .#bonVM {{options}}


nix-diff:
  # https://discourse.nixos.org/t/nvd-simple-nix-nixos-version-diff-tool/12397/28
  nix store diff-closures $(\ls -dv /nix/var/nix/profiles/per-user/croissong/profile-*-link | /usr/bin/tail -2) | rg →

nix-check-missing:
  # outdated
  # nix search nixpkgs '\.()'
  # missing
  nix-search '\.(focus|sttr|versio$|slidev|got$)'

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
  systemctl start nix-daemon
  @just --justfile $DOT/dot_config/updatecli/justfile -d $DOT/dot_config/updatecli apply
