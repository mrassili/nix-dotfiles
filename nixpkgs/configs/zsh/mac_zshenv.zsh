typeset -U path
path=($HOME/go/bin
      $HOME/.cargo/bin
      $HOME/.poetry/bin
      $HOME/.emacs.d/bin
      /usr/local/bin
      /usr/local/sbin
      /usr/bin
      $path)

#nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
