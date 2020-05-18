{ config, pkgs, libs, ... }:

{
  home.packages = with pkgs; [
    nix-du
    niv
    nix-index
    nix-prefetch
    nix-prefetch-github
    nix-prefetch-git
    nextcloud-client
    nixpkgs-fmt
  ];
}
