typeset -U path
path=($HOME/.emacs.d/bin
      $HOME/.dotnet
      $path
      $HOME/miniconda3/bin)

fpath=($HOME/.zsh/completion $fpath)

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
