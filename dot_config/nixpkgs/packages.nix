{ pkgs, ... }: {
  home.packages = with pkgs; [
    batsignal # A lightweight battery monitor daemon
    jless # A command-line pager for JSON data
    yq-go # Portable command-line YAML processor
  ];




  nixpkgs.overlays = [
    (self: super: {
      batsignal = super.batsignal.overrideAttrs (prev: rec {
        version = "1.5.0";
        src = super.fetchFromGitHub {
          rev = version;
          sha256 = "sha256-gZMGbw7Ij1IVQSWOqG/91YrbWTG3I3l6Yp11QbVCfyY=";
          repo = "batsignal";
          owner = "electrickite";
        };
      });
    })
  ];





  # home.packages = with pkgs; [
  # ugrep # ultra fast grep with interactive TUI, fuzzy search, boolean queries, hexdumps and more
  # ];
}
