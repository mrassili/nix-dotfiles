{ config, pkgs, libs, ... }:

{
  home.packages = with pkgs; [
    ark
    bitwarden
    firefox
    gnome3.geary
    gwenview
    latte-dock
    okular
    graphviz
    libreoffice
    openssh
    spotify
    simplescreenrecorder
    unityhub
    exercism
    # xpra
    zgrviewer
    nerdfonts
    spectacle
    steam
    wireguard-tools
    virtualgl
    zotero
  ];
}
