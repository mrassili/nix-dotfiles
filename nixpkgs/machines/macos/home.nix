{ pkgs, ... }:
let
  sources = import ../../nix/sources.nix;
in
{
  imports = [
    ../../modules/cli.nix
    ../../modules/git.nix
    ../../modules/neovim.nix
    ../../modules/nix-utilities.nix
    ../../modules/ssh.nix
    ../../modules/weechat.nix
  ];

  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";
  home.stateVersion = "20.09";

  home.packages = with pkgs; [
      mu
      isync
    ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacsMacport;
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

  home.file.".zshenv".source = ../../configs/zsh/mac_zshenv.zsh;

}
