{ config, ... }:

let
  sources = import ./nix/sources.nix;
  pkgs-unstable = import sources.nixpkgs-unstable {};
in
{
  # Let Home Manager install and manage itself.
  imports = [
    ./modules/shell/zsh.nix
  ];
  programs.home-manager.enable = true;

  home.packages = with pkgs-unstable; [
      ark
      alacritty
      awscli
      bitwarden
      blender
      cudatoolkit_10_1
      cudnn_cudatoolkit_10_1
      coreutils
      curl
      direnv
      dotnetCorePackages.netcore_3_1
      discord
      emacs
      exercism
      fd
      ffsend
      firefox
      gitAndTools.gh
      gnome3.geary
      git-lfs
      gnupg
      gnutls
      graphviz
      gwenview
      handbrake
      htop
      ldmtool
      lorri
      libsixel
      luajit
      mosh
      niv
      neovim
      nerdfonts
      nix-index
      nix-prefetch
      nix-prefetch-github
      nix-prefetch-git
      nixpkgs-fmt
      nmap
      nodejs-13_x
      nnn
      openssh
      poetry
      pre-commit
      rsync
      riot-desktop
      ripgrep
      sd
      signal-desktop
      simplescreenrecorder
      slack
      socat
      spectacle
      spotify
      steam
      termshark
      tldr
      tmux
      universal-ctags
      vlc
      unityhub
      unzip
      watch
      watchman
      wireguard-tools
      xpra
      xsv
      ytop
      virtualgl
      zgrviewer
      zotero
      zsh
    ];
  

  services.lorri.enable = true;
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.03";
}
