{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    haskellPackages.ghc
    haskellPackages.ghcide
    rust-analyzer
  ];
}
