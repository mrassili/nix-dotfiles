let
  sources = import ../nix/sources.nix;
  fetchGitHubArchive = { owner, repo, rev, sha256 }: builtins.fetchTarball {
    url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
    inherit sha256;
  };
in import (fetchGitHubArchive {
  inherit (sources.emacs-overlay) owner repo rev sha256;
})
