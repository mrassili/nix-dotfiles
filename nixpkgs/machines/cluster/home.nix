{ config, pkgs, libs, ... }:
let
  sources = import ../../nix/sources.nix;
  pkgs = import sources.nixpkgs-unstable { };
in
{
  # Let Home Manager install and manage itself.
  imports = [
    ../../modules/cli.nix
    ../../modules/editors.nix
    ../../modules/git.nix
    ../../modules/nix-utilities.nix
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = false;
    initExtraBeforeCompInit = builtins.readFile ../../configs/zsh/fedora_zshrc.zsh;
    plugins = [{
      name = "powerlevel10k";
      src = pkgs.fetchFromGitHub {
        inherit (sources.powerlevel10k) owner repo rev sha256;
      };
    }];
  };

  services.lorri.enable = true;
  programs.home-manager.enable = true;

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
