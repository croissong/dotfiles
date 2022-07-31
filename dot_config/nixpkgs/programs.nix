{pkgs, ...}: let
in {
  programs = {
    go = {
      enable = true;
    };

    java = {
      enable = true;
    };
  };
}
