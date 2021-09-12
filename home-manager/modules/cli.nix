{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    #awscli
    bat
    bitwarden-cli
    bottom
    curl
    du-dust
    exa
    fd
    # ffsend
    fzf
    gawk
    gnupg
    gnused
    gnutls
    google-cloud-sdk
    keychain
    # mosh
    nix-zsh-completions
    nmap
    # nnn
    rclone
    ripgrep
    rsync
    sd
    socat
    termshark
    tealdeer
    tmux
    tree
    universal-ctags
    unzip
    watch
    watchman
    xsv
    zoxide
    # starship
    zsh
    spotify-tui
    spotifyd
    # zsh-powerlevel10k
  ];


  programs.direnv = {
    enable = true;
    enableZshIntegration = false;
    # enableNixDirenvIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = false;
    initExtraFirst = ''
      # Emacs tramp mode compatibility
      [[ $TERM == "tramp" ]] && unsetopt zle && PS1='$ ' && return

      # Hook direnv
      emulate zsh -c "$(direnv export zsh)"

      # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
      # Initialization code that may require console input (password prompts, [y/n]
      # confirmations, etc.) must go above this block; everything else may go below.
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
      # eval "$(starship init zsh)"

      # Enable direnv
      emulate zsh -c "$(direnv hook zsh)"
    '';
    initExtraBeforeCompInit = builtins.readFile ../configs/zsh/zshrc.zsh + ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/config/p10k-lean.zsh
      export POWERLEVEL9K_SHOW_RULER=false
      export POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_CHAR=" "
      export POWERLEVEL9K_MULTILINE_FIRST_PROMPT_SUFFIX=""
      export POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_SUFFIX=""
      export POWERLEVEL9K_MULTILINE_LAST_PROMPT_SUFFIX=""
      export POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(virtualenv anaconda direnv nix_shell)
    '';

  };

  programs.fzf.enable = true;

  xdg.configFile."git/config".source = ../configs/git/gitconfig;
  home.file.".aws/config".source = ../configs/aws/aws_config;
  xdg.configFile."dircolors".source = pkgs.LS_COLORS.outPath + "/LS_COLORS";
  xdg.configFile."tmux/tmux.conf".source = ../configs/tmux/tmux.conf;
  xdg.configFile."direnv/lib/poetry.sh".source = ../configs/direnv/poetry.sh;
  xdg.configFile."kitty/kitty.conf".source = ../configs/terminal/kitty.conf;
  xdg.configFile."starship.toml".source = ../configs/terminal/starship.toml;
}
