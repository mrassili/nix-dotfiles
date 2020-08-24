{ config, pkgs, libs, ... }:

{
  home.packages = with pkgs;  with stdenv.lib; [
    rnix-lsp
  ] ++ optionals stdenv.isLinux [ python-language-server ] ;
  programs.neovim = {
      enable = true;
      package = pkgs.neovim-nightly;
      extraConfig = builtins.readFile ../configs/neovim/init.vim;
      plugins = with pkgs.vimPlugins; [
            vim-vinegar
            vim-sensible
            vim-surround
            vim-fugitive
            vim-rhubarb
            vim-dispatch
            vim-repeat
            vim-sleuth
            vim-eunuch
            vim-unimpaired
            vim-commentary
            splitjoin-vim
            vim-gutentags
            vim-easy-align
            fzf-vim
            fzfWrapper
            vim-dirvish
            onedark-vim
            lightline-vim
            vim-tmux-navigator
            vimtex
            # neovim-remote
            indentLine
            vim-slime
            vim-gitgutter
            # nvim-luadev
            # vimspector
            nvim-lsp
            diagnostic-nvim
            completion-nvim
            neoformat
          ];
    };
}
