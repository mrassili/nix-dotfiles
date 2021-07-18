{ config, pkgs, libs, ... }:
{
  
  home.packages = with pkgs; [
    neovim-nightly
    rnix-lsp
    rust-analyzer
    vale
    shellcheck
    gopls
    stylua
    nodePackages.pyright
    (if pkgs.stdenv.isDarwin then pkgs.sumneko-lua-language-server-mac else pkgs.sumneko-lua-language-server)
  ];
  xdg.configFile."nvim/init.lua".source = config.lib.file.mkOutOfStoreSymlink (config.home.homeDirectory + "/Repositories/nix/nix-dotfiles/home-manager/configs/neovim/init.lua");
  xdg.configFile."nvim/init_test.lua".source = config.lib.file.mkOutOfStoreSymlink (config.home.homeDirectory + "/Repositories/nix/nix-dotfiles/home-manager/configs/neovim/init_test.lua");
  # fzf-native
  xdg.dataFile."nvim/site/pack/packer/start/telescope-fzf-native.nvim/build/libfzf.so".source = "${pkgs.telescope-fzf-native}/build/libfzf.so";
  # tree-sitter parsers
  xdg.configFile."nvim/parser/c.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-c}/parser";
  xdg.configFile."nvim/parser/lua.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-lua}/parser";
  xdg.configFile."nvim/parser/rust.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-rust}/parser";
  xdg.configFile."nvim/parser/python.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-python}/parser";
}
