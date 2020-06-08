{ config, pkgs, libs, ... }:
let
  sources = import ../../nix/sources.nix;
  pkgs = import sources.nixpkgs-unstable { };
in
{
  imports = [
    ../../modules/cli.nix
    ../../modules/git.nix
    ../../modules/editors.nix
    ../../modules/nix-utilities.nix
    ../../modules/ssh.nix
  ];
  # Let Home Manager install and manage itself.
  home.packages = with pkgs; [
      mu
      isync
    ];

  programs.zsh = {
    enable = true;
    enableCompletion = false;
    initExtraBeforeCompInit = builtins.readFile ../../configs/zsh/mac_zshrc.zsh;
    plugins = [{
      name = "powerlevel10k";
      src = pkgs.fetchFromGitHub {
        inherit (sources.powerlevel10k) owner repo rev sha256;
      };
    }];
  };

  home.file.".zshenv".source = ../../configs/zsh/mac_zshenv.zsh;
  programs.home-manager.enable = true;
}
