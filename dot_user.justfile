!include Dot/priv/justfile


# https://github.com/casey/just/issues/1557
# default:
#   @just --justfile {{justfile()}} --choose

vpnio-start:
  systemctl restart strongswan
  sudo swanctl -i -c vpn
vpnio-stop:
  systemctl stop strongswan


nix *args: nix-cm (nix-hm args) nix-diff nix-check-missing

nix-cm:
  #!/usr/bin/env bash
  cd $DOT/dot_config/nixpkgs/
  chezmoi apply ~/.config/nixpkgs

nix-hm *args:
  home-manager --impure switch \
  --flake ~/.config/nixpkgs#moi \
  --update-input nixpkgs \
  --update-input home-manager \
  --update-input nixpkgs-stable \
  --update-input rust-overlay \
  --update-input tree-grepper {{args}}
  # --update-input nixpkgs-master \


nix-diff:
  # https://discourse.nixos.org/t/nvd-simple-nix-nixos-version-diff-tool/12397/28
  nix store diff-closures $(\ls -dv /nix/var/nix/profiles/per-user/croissong/profile-*-link | /usr/bin/tail -2) | rg →

nix-check-missing:
  # outdated
  # nix search nixpkgs '\.()'
  # missing
  nix search nixpkgs '\.(csvlens|klog|focus|gup|termshot|mailctl|sttr|versio$|slidev|updatecli|got$)'

gc:
  podman system prune --all --force && podman rmi --all --force
  nix-collect-garbage -d


scan out:
  sy restart avahi-daemon.service
  scan --verbose --mode Color --resolution 600 -e 1 --no-default-size \
    -x 'airscan:e0:Canon TS5000 series' \
    --unpaper --ocr \
    -o {{out}}.pdf


updatecli:
  systemctl start nix-daemon
  @just --justfile $DOT/dot_config/updatecli/justfile -d $DOT/dot_config/updatecli apply
