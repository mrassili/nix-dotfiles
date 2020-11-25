{ config, pkgs, libs, ... }:
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
