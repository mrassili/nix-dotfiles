let
  pkgs = import <nixpkgs> { };
  lib = pkgs.lib;

  emacsOverlay = import ((import ./nixos/nix/sources.nix).emacs-overlay);
  emacsNixpkgsTarball = builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/3496a883c306186ae802011d3b39020c43efd384.tar.gz";
  emacsPkgs = (import emacsNixpkgsTarball) {
    overlays = [ emacsOverlay ];
  };

  libPath = lib.concatStringsSep ":" [
    "${lib.getLib emacsPkgs.libgccjit}/lib/gcc/${emacsPkgs.targetPlatform.config}/${emacsPkgs.libgccjit.version}"
    "${lib.getLib emacsPkgs.stdenv.cc.cc}/lib"
    "${lib.getLib emacsPkgs.stdenv.glibc}/lib"
  ];

  emacsWrapped = pkgs.symlinkJoin {
    name = "emacsWrapped";
    paths = [ emacsPkgs.emacsGcc ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/emacs \
        --set LIBRARY_PATH ${libPath}
    '';
  };
in
pkgs.stdenv.mkDerivation {
  name = "doom-gcc-emacs";
  buildInputs = [ emacsWrapped ];

  shellHook = ''
    DOOMDIR=~/dotfiles/doom-emacs
    export DOOMLOCALDIR="$DOOMDIR/.local_gcc"

    mkdir -p "$DOOMLOCALDIR/straight"
    pushd "$DOOMLOCALDIR/straight" >/dev/null
    if [[ ! -d ./repos ]]; then
      cp -r "$DOOMDIR/.local/straight/repos" ./repos
    fi
    popd >/dev/null
  '';
}
