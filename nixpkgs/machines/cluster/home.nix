{ pkgs, ... }:
let
  sources = import ../../nix/sources.nix;
in
{
  imports = [
    ../../modules/cli.nix
    ../../modules/neovim.nix
    ../../modules/git.nix
    ../../modules/nix-utilities.nix
  ];

  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";
  home.stateVersion = "20.09";
  home.sessionVariables = {
    LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
  };

  programs.bash.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = false;
    initExtraBeforeCompInit = builtins.readFile ../../configs/zsh/fedora_zshrc.zsh;
    initExtra = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/config/p10k-lean.zsh
    '';
  };

  services.lorri.enable = true;

}
