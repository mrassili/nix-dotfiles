{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    discord
    element-desktop
    slack
    signal-desktop
  ];
}
