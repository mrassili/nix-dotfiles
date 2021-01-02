{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    hydra-check
    # nix-du
    # nix-index
    nix-prefetch-github
    # nix-prefetch
    # nix-prefetch-git
    nixpkgs-review
    nix-top
    nixpkgs-fmt
  ];
}
