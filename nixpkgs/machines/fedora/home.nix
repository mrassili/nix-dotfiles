{ config, pkgs, libs, ... }:
let
  sources = import ../../nix/sources.nix;
  pkgs = import sources.nixpkgs-unstable { };
  nixos-unstable = import sources.nixos-unstable { };
in
{
  # Let Home Manager install and manage itself.
  imports = [
    ../../modules/cli.nix
    ../../modules/cuda.nix
    ../../modules/editors.nix
    ../../modules/git.nix
    ../../modules/nix-utilities.nix
    # ../../modules/python.nix
    ../../modules/ssh.nix
  ];

  home.packages = with pkgs; [
      mu
      isync
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

  programs.emacs = {
    enable = true;
    package = nixos-unstable.emacsGcc;
  };

  xdg.configFile."alacritty/alacritty.yml".source = ../../configs/terminal/alacritty.yml;
  services.lorri.enable = true;
  programs.home-manager.enable = true;
  programs.bash.enable = true;

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
