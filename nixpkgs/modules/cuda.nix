{ config, pkgs, libs, ... }:
let
  pkgs = (import ../default.nix).packages.${builtins.currentSystem}; 
in
{
  home.packages = with pkgs; [
    cudatoolkit_10_1
    cudnn_cudatoolkit_10_1
  ];
}
