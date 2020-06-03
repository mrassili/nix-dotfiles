let
  fetchGitHubArchive = { owner, repo, rev, sha256 }: builtins.fetchTarball {
    url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
    inherit sha256;
  };
in import (fetchGitHubArchive {
  owner = "nix-community";
  repo = "emacs-overlay";
  rev = "a7456b41281507d4f6838cedf89290f4f3b4e02f";
  sha256 = "17a1cd0xfhhhmnjglasixb7dmdgyibxwllddw7r1id1vvbsz1zxg";
})
