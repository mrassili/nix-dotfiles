{ config, pkgs, libs, ... }:
let
  pkgs = (import ../default.nix).packages.${builtins.currentSystem}; 
in
{
  home.packages = with pkgs; [
    alacritty
    libsixel
  ];
  xdg.configFile."alacritty/alacritty.yml".source = ../configs/terminal/alacritty.yml;
}
