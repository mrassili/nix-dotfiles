{ config, pkgs, libs, ... }:

{
  home.packages = with pkgs;  with stdenv.lib; [
    neovim-nightly
    rnix-lsp
  ] ++ optionals stdenv.isLinux [ python-language-server ] ;
  xdg.configFile."nvim/init.vim".source = ../configs/neovim/init.vim;
  # programs.vim = {
  #     enable = true;
  #     extraConfig = ''
  #        colorscheme onedark
  #       '';
  #     plugins = with pkgs.vimPlugins; [
  #           onedark-vim
  #         ];
  #   };
}
