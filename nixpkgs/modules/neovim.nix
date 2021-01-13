{ config, pkgs, libs, ... }:
{
  
  home.packages = with pkgs; [
    neovim-nightly
    rnix-lsp
    gopls
    nodePackages.pyright
  ];
  xdg.configFile."nvim/init.lua".source = ../configs/neovim/init.lua;
  # programs.neovim = {
  #   enable = true;
  #   package = pkgs.neovim-nightly;
  #   # extraConfig = builtins.readFile ../configs/neovim/init.vim;
  #   withNodeJs = true;
  #   # plugins = with pkgs.vimPlugins; [
  #   #   # nvim-luadev
  #   #   completion-nvim
  #   #   fzf-vim
  #   #   fzfWrapper
  #   #   indentLine
  #   #   lightline-vim
  #   #   neoformat
  #   #   nvim-lspconfig
  #   #   onedark-vim
  #   #   splitjoin-vim
  #   #   vim-commentary
  #   #   vim-dirvish
  #   #   vim-dispatch
  #   #   vim-easy-align
  #   #   vim-eunuch
  #   #   vim-fugitive
  #   #   vim-gitgutter
  #   #   vim-gutentags
  #   #   vim-polyglot
  #   #   vim-repeat
  #   #   vim-rhubarb
  #   #   vim-sensible
  #   #   vim-sleuth
  #   #   vim-slime
  #   #   vim-surround
  #   #   vim-tmux-navigator
  #   #   vim-unimpaired
  #   #   vim-vinegar
  #   #   vimtex
  #   # ];
  #   extraPackages = with pkgs; [
  #     rnix-lsp
  #     gopls
  #     nodePackages.pyright
  #     neovim-remote
  #     luajitPackages.lua-lsp
  #   ];
  # };
}
