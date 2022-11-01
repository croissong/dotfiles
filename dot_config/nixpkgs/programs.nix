{pkgs, ...}: let
in {
  imports = [
    ./firefox.nix
  ];

  programs = {
    go = {
      enable = true;
    };

    java = {
      enable = true;
    };
  };
}
