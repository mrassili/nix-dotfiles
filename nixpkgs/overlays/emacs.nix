self: super:
let
  libPath = with super; lib.concatStringsSep ":" [
    "${lib.getLib libgccjit}/lib/gcc/${stdenv.targetPlatform.config}/${libgccjit.version}"
    "${lib.getLib stdenv.cc.cc}/lib"
    "${lib.getLib stdenv.glibc}/lib"
  ];
  emacs-overlay=import (builtins.fetchTarball {
          url = https://github.com/mjlbach/emacs-pgtk-nativecomp-overlay/archive/master.tar.gz;
        });
in {
  emacsGccPgtkWrapped = super.symlinkJoin {
    name = "emacsGccPgtkWrapped";
    paths = [ emacs-overlay.emacsGccPgtk ];
    buildInputs = [ super.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/emacs \
      --set LIBRARY_PATH ${libPath}
    '';
    meta.platforms = super.stdenv.lib.platforms.linux;
    passthru.nativeComp = true;
    src = emacs-overlay.emacsGccPgtk.src;
  };
}
