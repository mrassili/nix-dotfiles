let
  fetchGitHubArchive = { owner, repo, rev, sha256 }: builtins.fetchTarball {
    url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
    inherit sha256;
  };
in import (fetchGitHubArchive {
  owner = "nix-community";
  repo = "emacs-overlay";
  rev = "4a055e0e8bbf7c2b304bd671d94843ae3fe8f55b";
  sha256 = "0aad4l8z7war9w9s4j5s2sx91br8b768p65az2vfgpm8qm5q998p";
})
