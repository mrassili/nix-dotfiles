{ config, pkgs, libs, ... }:

{
  home.packages = with pkgs; [
    alacritty
    libsixel
  ];
}
