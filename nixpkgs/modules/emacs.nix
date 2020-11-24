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
    package = if pkgs.stdenv.isDarwin then pkgs.nixos-unstable.emacsGcc else pkgs.nixos-unstable.emacsPgtkGcc;
    # extraPackages = (epkgs: [ epkgs.vterm ] );
  };

}
