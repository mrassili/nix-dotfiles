{ config, pkgs, libs, ... }:
let
  pkgs = (import ../default.nix).packages.${builtins.currentSystem}; 
in
{
  home.file.".ssh/config".source = ../configs/ssh/ssh_config;
}
