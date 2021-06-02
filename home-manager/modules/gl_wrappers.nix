{ config, pkgs, ... }:
let nixGLIntel = (pkgs.callPackage "${builtins.fetchTarball {
      url = https://github.com/guibou/nixGL/archive/17c1ec63b969472555514533569004e5f31a921f.tar.gz;
      sha256 = "0yh8zq746djazjvlspgyy1hvppaynbqrdqpgk447iygkpkp3f5qr";
    }}/nixGL.nix"
  { }).nixGLIntel;
in
{
  programs.alacritty = {
    enable = true;
    package =
      pkgs.writeShellScriptBin "alacritty" ''
        #!/bin/sh

        ${nixGLIntel}/bin/nixGLIntel ${pkgs.alacritty}/bin/alacritty "$@"
      '';
  };
}
