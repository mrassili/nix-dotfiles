typeset -U path
path=($HOME/go/bin
      $HOME/.nix-profile/bin
      $HOME/.cargo/bin
      $HOME/.poetry/bin
      $HOME/.config/emacs/bin
      /Library/TeX/texbin
      /usr/local/bin
      /usr/local/sbin
      /usr/local/go/bin
      /Users/michael/.npm-packages/bin
      /Applications/VMware Fusion.app/Contents/Public
      /usr/bin
      $path)

#nix
# if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
#   . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
# fi

. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH

conda() {
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/michael/.local/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/michael/.local/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/michael/.local/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/michael/.local/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
conda "$@"
}
