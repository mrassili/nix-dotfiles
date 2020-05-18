{ config, pkgs, libs, ... }:
let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs-unstable { };
in
{
  # Let Home Manager install and manage itself.
  imports = [
    ./modules/cli.nix
    ./modules/python.nix
    ./modules/cuda.nix
    ./modules/alacritty.nix
    ./modules/chat.nix
    ./modules/git.nix
    ./modules/media.nix
    ./modules/nixos-desktop.nix
    ./modules/nix-utilities.nix
    ./modules/editors.nix
  ];

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
