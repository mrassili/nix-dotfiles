{ config, pkgs, libs, ... }:
{
  
  home.packages = with pkgs; [
    neovim-nightly
    rnix-lsp
    rust-analyzer
    vale
    shellcheck
    gopls
    nodePackages.pyright
    (if pkgs.stdenv.isDarwin then pkgs.sumneko-lua-language-server-mac else pkgs.sumneko-lua-language-server)
  ];
  # xdg.configFile."nvim/init.lua".source = config.lib.file.mkOutOfStoreSymlink ../configs/neovim/init.lua;
  xdg.configFile."nvim/init.lua".source = ../configs/neovim/init.lua;
  xdg.dataFile."nvim/site/pack/packer/start/telescope-fzf-native.nvim/build/libfzf.so".source = "${pkgs.telescope-fzf-native}/build/libfzf.so";
  xdg.configFile."nvim/parser/c.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-c}/parser";
  xdg.configFile."nvim/parser/lua.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-lua}/parser";
  xdg.configFile."nvim/parser/rust.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-rust}/parser";
  xdg.configFile."nvim/parser/python.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-python}/parser";
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
