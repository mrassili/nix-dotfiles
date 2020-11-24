{ config, pkgs, libs, ... }:
let
  pkgs = (import ../default.nix).packages.${builtins.currentSystem}; 
in
{
  home.packages = with pkgs; [
    git-lfs
    gitAndTools.delta
    gitAndTools.gh
    gitAndTools.git-crypt
    pre-commit
  ];
}
