{ config, pkgs, libs, ... }:
let
  pkgs = (import ../default.nix).packages.${builtins.currentSystem}; 
in
{
  home.packages = with pkgs; [
    haskellPackages.ghc
    haskellPackages.ghcide
    rust-analyzer
  ];
}
