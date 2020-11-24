{ config, pkgs, libs, ... }:
{
  home.stateVersion = "20.09";

  programs.man.enable = false;
  home.extraOutputsToInstall = [ "man" ];

  # home.sessionVariables = {
  #   LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
  # };
}
