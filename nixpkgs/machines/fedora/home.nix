{ pkgs, ... }:

{
  imports = [
    ../../modules/home-manager.nix
    ../../modules/cli.nix
    #../../modules/cuda.nix
    ../../modules/git.nix
    ../../modules/nix-utilities.nix
    # ../../modules/python.nix
    ../../modules/neovim.nix
    ../../modules/languages.nix
    ../../modules/emacs.nix
    ../../modules/ssh.nix
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = false;
    initExtraBeforeCompInit = builtins.readFile ../../configs/zsh/fedora_zshrc.zsh;
    initExtra = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/config/p10k-lean.zsh
    '';
  };

  xdg.configFile."alacritty/alacritty.yml".source = ../../configs/terminal/alacritty.yml;
}
