self: super:
let
  sources = import ../nix/sources.nix;
  fetchGitHubArchive = { owner, repo, rev, sha256 }: builtins.fetchTarball {
    url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
    inherit sha256;
  };
  libPath = with super; lib.concatStringsSep ":" [
    "${lib.getLib libgccjit}/lib/gcc/${stdenv.targetPlatform.config}/${libgccjit.version}"
    "${lib.getLib stdenv.cc.cc}/lib"
    "${lib.getLib stdenv.glibc}/lib"
  ];
  emacs-overlay = (import (fetchGitHubArchive {
    inherit (sources.emacs-overlay) owner repo rev sha256;
  }) self super);
  # emacs-overlay = (import (fetchGitHubArchive {
  #   owner = "nix-community";
  #   repo = "emacs-overlay";
  #   rev = "413dc6ac8945769e996df118778be64a5c6da48e";
  #   sha256= "09pf0kqn0dihgwmkzjhcyjc8xbp21js30ymszwrbmd5wbncr39n5";
  #   # inherit (sources.emacs-overlay) owner repo rev sha256;
  # }) self super);
in {

  emacsGccWrapped = super.symlinkJoin {
    name = "emacsGccWrapped";
    paths = [ emacs-overlay.emacsGcc ];
    buildInputs = [ super.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/emacs \
      --set LIBRARY_PATH ${libPath}
    '';
    meta.platforms = super.stdenv.lib.platforms.linux;
    passthru.nativeComp = true;
    src = emacs-overlay.emacsGcc.src;
  };
} // emacs-overlay
