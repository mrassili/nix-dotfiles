{ config, pkgs, libs, ... }:
let
  pkgs = (import ../default.nix).packages.${builtins.currentSystem}; 
in
{
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";
  home.stateVersion = "20.09";

  programs.man.enable = false;
  home.extraOutputsToInstall = [ "man" ];

  # home.sessionVariables = {
  #   LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
  # };
}
