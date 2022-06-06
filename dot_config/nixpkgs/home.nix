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
    nixpkgs-fmt
    pkgs.termdown # Countdown timer and stopwatch in your terminal
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
