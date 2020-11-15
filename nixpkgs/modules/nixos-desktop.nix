{ config, pkgs, libs, ... }:

{
  home.packages = with pkgs; [
    xpra
    ark
    bitwarden
    exercism
    firefox
    gnome3.geary
    graphviz
    gwenview
    latte-dock
    libreoffice-qt
    (nerdfonts.override { fonts = [ "Meslo" ]; })
    nextcloud-client
    okular
    openssh
    simplescreenrecorder
    spectacle
    spotify
    steam
    unityhub
    virtualgl
    wireguard-tools
    zgrviewer
    zotero
  ];
}
