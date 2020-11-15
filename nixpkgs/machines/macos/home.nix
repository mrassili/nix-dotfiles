{ pkgs, ... }:

{
  imports = [
    ../../modules/home-manager.nix
    ../../modules/cli.nix
    ../../modules/git.nix
    ../../modules/neovim.nix
    ../../modules/nix-utilities.nix
    ../../modules/ssh.nix
    ../../modules/weechat.nix
  ];

  home.packages = with pkgs; [
      mu
      isync
    ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacsGcc;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = false;
    initExtraBeforeCompInit = builtins.readFile ../../configs/zsh/mac_zshrc.zsh;
    initExtra = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/config/p10k-lean.zsh
    '';
  };

}
