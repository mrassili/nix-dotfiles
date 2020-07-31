{ config, pkgs, libs, ... }:

let
  sources = import ../../nix/sources.nix;
  nixos-unstable = import sources.nixos-unstable { };
in

{
  home.packages = with pkgs; [
      languagetool
      mu
      isync
    ];

  programs.emacs = {
    enable = true;
    package = nixos-unstable.emacsGcc;
    extraPackages = (epkgs: [ epkgs.vterm ] );
  };

}
