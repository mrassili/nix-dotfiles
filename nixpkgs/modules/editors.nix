{ config, pkgs, libs, ... }:

{
  home.packages = with pkgs; [
    neovim
    python-language-server
    rnix-lsp
  ];
  programs.emacs.enable = true;
  services.emacs.enable = true;
}
