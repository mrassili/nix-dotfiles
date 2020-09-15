typeset -U path
path=($HOME/go/bin
      $HOME/.cargo/bin
      $HOME/.poetry/bin
      $HOME/.config/emacs/bin
      /Library/TeX/texbin
      /usr/local/bin
      /usr/local/sbin
      /usr/local/go/bin
      /Users/michael/.npm-packages/bin
      /usr/bin
      $path)

#nix
# if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
#   . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
# fi

 test -r /Users/michael/.opam/opam-init/init.zsh && . /Users/michael/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
