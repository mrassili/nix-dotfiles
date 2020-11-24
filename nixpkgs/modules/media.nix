{ config, pkgs, libs, ... }:
let
  pkgs = (import ../default.nix).packages.${builtins.currentSystem}; 
in
{
  home.packages = with pkgs; [
    blender
    handbrake
    krita
    vlc
    gimp
  ];
}
