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
      awscli
      bitwarden
      blender
      cudatoolkit_10_1
      cudnn_cudatoolkit_10_1
      coreutils
      curl
      gitAndTools.delta
      direnv
      dotnetCorePackages.netcore_3_1
      discord
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
      keychain
      lorri
      libsixel
      luajit
      mosh
      niv
      neovim
      nerdfonts
      nix-du
      nix-index
      nix-prefetch
      nix-prefetch-github
      nix-prefetch-git
      nixpkgs-fmt
      nmap
      nodejs-13_x
      nnn
      openssh
      okular
      poetry
      # python-language-server
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
  programs.emacs.enable = true;
  services.emacs.enable = true;
  # services.emacs.client.enable = true;
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
