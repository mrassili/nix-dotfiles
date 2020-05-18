{ config, pkgs, libs, ... }:

{
  home.packages = with pkgs; [
    discord
    riot-desktop
    slack
    signal-desktop
  ];
}
