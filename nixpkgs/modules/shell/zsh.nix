{ config, pkgs, libs, ... }:

let 
  sources = import ../../nix/sources.nix;
in
{
  home = {

    packages = with pkgs; [
      zsh
      nix-zsh-completions
      bat
      exa
      fd
      fzf
      htop
      tmux
      ripgrep
      tree
      universal-ctags
      z-lua
      sources.LS_COLORS
    ];
  };

  programs.zsh = {
    enable = true;
    enableCompletion= false;
    initExtraBeforeCompInit = builtins.readFile ./zshrc.zsh ;
    plugins = [ {
      name = "powerlevel10k";
      src =  pkgs.fetchFromGitHub {
        inherit (sources.powerlevel10k) owner repo rev sha256;
       };
     }
    ];
  };

  home.file.".dircolors".source = sources.LS_COLORS.outPath + "/LS_COLORS";
  home.file.".tmux.conf".source = ./tmux.conf;
  xdg.configFile."alacritty/alacritty.yml".source = ../terminal/alacritty.yml;
}

