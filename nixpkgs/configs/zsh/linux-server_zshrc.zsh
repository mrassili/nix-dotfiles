typeset -U path
path=(
      $HOME/.nix-profile/bin
      $path
    )

conda() {
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/.local/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/.local/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/.local/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/.local/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
conda "$@"
}

snvim() {
      /usr/local/bin/nvim -u ~/.config/nvim/init_test.lua $@
}

home-upgrade () {
  nix flake update $HOME/.config/nixpkgs --recreate-lock-file
  nix build "$HOME/.config/nixpkgs#linux-server" -o "$HOME/.config/nixpkgs/result"
  zsh "$HOME/.config/nixpkgs/result/activate"
}

home-switch () {
  nix build "$HOME/.config/nixpkgs#linux-server" -o "$HOME/.config/nixpkgs/result"
  zsh "$HOME/.config/nixpkgs/result/activate"
}
