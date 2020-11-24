{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    poetry
    (python37.withPackages (ps: with ps; [ pip ]))
  ];
}
