{ config, pkgs, libs, ... }:
let
  pkgs = (import ../default.nix).packages.${builtins.currentSystem}.nixos-unstable; 
in
{
  home.packages = with pkgs; [
    languagetool
    mu
    isync
    sqlite
    ispell
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacsPgtkGcc;
    # extraPackages = (epkgs: [ epkgs.vterm ] );
  };

}
