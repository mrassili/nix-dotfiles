{ config, pkgs, libs, ... }:

{
  home.packages = with pkgs;  with stdenv.lib; [
    neovim
    rnix-lsp
  ] ++ optionals stdenv.isLinux [ python-language-server ] ;
  xdg.configFile."nvim/init.vim".source = ../configs/neovim/init.vim;
}
