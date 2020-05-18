{ config, pkgs, libs, ... }:

{
  home.packages = with pkgs; [
    neovim
    rnix-lsp
  ];
  xdg.configFile."nvim/init.vim".source = ../configs/neovim/init.vim;
}
