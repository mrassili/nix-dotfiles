{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    ark
    bitwarden
    exercism
    firefox
    gnome3.geary
    graphviz
    gwenview
    kitty
    # libreoffice-qt
    (nerdfonts.override { fonts = [ "Meslo" ]; })
    nextcloud-client
    okular
    openssh
    simplescreenrecorder
    spectacle
    spotify
    steam
    # unityhub
    virtualgl
    wireguard-tools
    zgrviewer
    zotero
  ];
}
