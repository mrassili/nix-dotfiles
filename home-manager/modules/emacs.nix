{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    # languagetool
    mu
    isync
    sqlite
    ispell
  ];

  programs.emacs = {
    enable = true;
    # package = if pkgs.stdenv.isDarwin then pkgs.nixos-unstable.emacsGcc else pkgs.nixos-unstable.emacsPgtkGcc;
    # package = if pkgs.stdenv.isDarwin then pkgs.emacsMacport else pkgs.emacsPgtkGcc;
    package = if pkgs.stdenv.isDarwin then pkgs.emacsGcc else pkgs.emacsPgtkGcc;
    # (emacsPackagesFor emacsMacport).emacsWithPackages(ps: [ ps.seq ])
    # extraPackages = (epkgs: [ epkgs.vterm ] );
  };

}
