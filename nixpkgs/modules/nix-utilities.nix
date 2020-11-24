{ config, pkgs, libs, ... }:
let
  pkgs = (import ../default.nix).packages.${builtins.currentSystem}; 
in
{
  home.packages = with pkgs; [
    hydra-check
    #nix-du
    niv
    nix-index
    nix-prefetch
    nix-prefetch-github
    nix-prefetch-git
    nixpkgs-fmt
  ];
}
