{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    blender
    handbrake
    krita
    vlc
    gimp
  ];
}
