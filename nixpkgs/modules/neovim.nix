{ config, pkgs, libs, ... }:

{
  home.packages = with pkgs;  with stdenv.lib; [
    rnix-lsp
    neovim-remote
  ] ++ optionals stdenv.isLinux [ python-language-server ] ;
  programs.neovim = {
      enable = true;
      package = pkgs.neovim-nightly;
      extraConfig = builtins.readFile ../configs/neovim/init.vim;
      plugins = with pkgs.vimPlugins; [
            # nvim-luadev
            # vimspector
            completion-nvim
            diagnostic-nvim
            fzf-vim
            fzfWrapper
            indentLine
            lightline-vim
            neoformat
            nvim-lspconfig
            onedark-vim
            splitjoin-vim
            vim-commentary
            vim-dirvish
            vim-dispatch
            vim-easy-align
            vim-eunuch
            vim-fugitive
            vim-gitgutter
            vim-gutentags
            vim-polyglot
            vim-repeat
            vim-rhubarb
            vim-sensible
            vim-sleuth
            vim-slime
            vim-surround
            vim-tmux-navigator
            vim-unimpaired
            vim-vinegar
            vimtex
          ];
    };
}
