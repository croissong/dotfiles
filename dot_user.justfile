!include Dot/priv/justfile


default:
  @just --choose

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
  NIXPKGS_ALLOW_UNFREE=1 home-manager --impure switch \
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
  nix search nixpkgs '\.(sheldon|summon|goimapnotify)'
  # missing
  nix search nixpkgs '\.(csvlens|kubesess|klog|focus|gup|riff|termshot|mailctl|riff|sttr|versio$|slidev|updatecli|got$)'

gc:
  podman system prune --all --force && podman rmi --all --force
  nix-collect-garbage -d


scan:
  /tmp/scan --verbose --mode Color --resolution 600 -e 1 --open --ocr --no-default-size -x 'airscan:e1:Canon TS5000 series'

  # scanadf -L
  # scanadf -d pixma:04A91802_0B3458 -e 1 -S /tmp/scan_perpage --script-wait 0 0 --resolution 300 --mode Color -o /tmp/worlitz-kk.jpg


updatecli:
  @just --justfile $DOT/dot_config/updatecli/justfile -d $DOT/dot_config/updatecli apply
