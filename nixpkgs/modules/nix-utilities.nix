{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    hydra-check
    #nix-du
    # nix-index
    nix-prefetch-github
    # nix-prefetch
    # nix-prefetch-git
    nix-top
    nixpkgs-fmt
  ];
}
