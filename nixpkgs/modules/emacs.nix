{ config, pkgs, libs, ... }:
let
  pkgs = (import ../default.nix).packages.${builtins.currentSystem}; 
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
    package = pkgs.emacsGccPgtk;
    # extraPackages = (epkgs: [ epkgs.vterm ] );
  };

}
