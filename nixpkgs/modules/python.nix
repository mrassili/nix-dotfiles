{ config, pkgs, libs, ... }:
let
  pkgs = (import ../default.nix).packages.${builtins.currentSystem}; 
in
{
  home.packages = with pkgs; [
    poetry
    (python37.withPackages (ps: with ps; [ pip ]))
  ];
}
