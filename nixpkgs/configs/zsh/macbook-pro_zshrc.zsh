typeset -U path
path=(
      /run/current-system/sw/bin
      $HOME/.nix-profile/bin
      $HOME/.local/cargo/bin
      $HOME/.config/emacs/bin
      $HOME/.npm-packages/bin
      $HOME/.poetry/bin
      $HOME/flutter/bin
      $HOME/go/bin
      $HOME/.ghcup/bin
      /Applications/Julia-1.5.app/Contents/Resources/julia/bin
      /Users/michael/.gem/ruby/2.6.0/bin
      /Users/michael/n/bin
      /Library/TeX/Root/bin/x86_64-darwin/
      /Users/michael/.npm-packages/bin
      /usr/local/bin
      /usr/local/sbin
      /usr/bin
      /bin
      /sbin
      $path
    )

export TERMINFO=$HOME/.config/terminfo

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
  nix build "$HOME/.config/nixpkgs#macbook-pro" -o "$HOME/.config/nixpkgs/result"
  zsh "$HOME/.config/nixpkgs/result/activate"
  (( $+commands[doom] )) && doom -y upgrade
}

home-switch () {
  nix build "$HOME/.config/nixpkgs#macbook-pro" -o "$HOME/.config/nixpkgs/result"
  zsh "$HOME/.config/nixpkgs/result/activate"
}

system-upgrade () {
   nix flake update --recreate-lock-file $HOME/.config/darwin
   darwin-rebuild switch --flake $HOME/.config/darwin
}

system-switch () {
   darwin-rebuild switch --flake $HOME/.config/darwin
}
