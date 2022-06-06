{ pkgs, ... }: {
  targets.genericLinux.enable = true;

  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/misc/termdown/default.nix
   nixpkgs.overlays = [ (self: super: {
      termdown = super.termdown.overrideAttrs (prev: {
        version = "1.18.0";
        src = super.fetchFromGitHub {
          rev = "1.18.0";
          sha256 = "sha256-Hnk/MOYdbOl14fI0EFbIq7Hmc7TyhcZWGEg2/jmNJ5Y=";
          repo = "termdown";
          owner = "trehn";
        };
      });
    }) ];


   home.packages = with pkgs; [
    argocd                       # Declarative continuous deployment for Kubernetes
    calibre                # Ebook management application
    chezmoi # Manage your dotfiles across multiple machines
    nixpkgs-fmt
    pkgs.termdown # Countdown timer and stopwatch in your terminal
    wl-color-picker # A wayland color picker that also works on wlroots
  ];

  # home.stateVersion= "22.11";

  # programs.firefox = {
  #   enable = true;
  #   package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
  #     forceWayland = true;
  #     extraPolicies = {
  #       ExtensionSettings = {};
  #     };
  #   };
  # };
}
