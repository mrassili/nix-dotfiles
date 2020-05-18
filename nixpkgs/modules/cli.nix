{ config, pkgs, libs, sources, ... }:

{
  home.packages = with pkgs; [
    awscli
    bat
    coreutils
    curl
    direnv
    du-dust
    exa
    fd
    ffsend
    fzf
    gnupg
    gnutls
    htop
    keychain
    mosh
    nix-zsh-completions
    nmap
    nnn
    ripgrep
    rsync
    sd
    socat
    # sources.LS_COLORS
    termshark
    tldr
    tmux
    tree
    universal-ctags
    unzip
    watch
    watchman
    xsv
    ytop
    z-lua
    zsh
    zsh-powerlevel10k
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = false;
    initExtraBeforeCompInit = builtins.readFile ../configs/zshrc.zsh;
    # plugins = [{
    #   name = "powerlevel10k";
    #   src = pkgs.fetchFromGitHub {
    #     inherit (sources.powerlevel10k) owner repo rev sha256;
    #   };
    # }];
  };

  services.lorri.enable = true;
  # home.file.".zshrc".source = ./zshrc.zsh;
  # home.file.".dircolors".source = sources.LS_COLORS.outPath + "/LS_COLORS";
  home.file.".tmux.conf".source = ../configs/tmux.conf;
}
