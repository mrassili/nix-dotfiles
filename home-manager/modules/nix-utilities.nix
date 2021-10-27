{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    nix-prefetch-github
    nixpkgs-review
    nix-top
    nixpkgs-fmt
  ] ++ (lib.optionals (!stdenv.isDarwin) [hydra-check] )
  ;
}
