{ config, pkgs, libs, ... }:
let
  pkgs = (import ../default.nix).packages.${builtins.currentSystem}; 
in
{
  home.packages = with pkgs; [
    discord
    element-desktop
    slack
    signal-desktop
  ];
}
