typeset -U path
path=(
      $HOME/.nix-profile/bin
      /run/current-system/sw/bin
      $HOME/.local/cargo/bin
      $HOME/.config/emacs/bin
      $HOME/.npm-packages/bin
      $HOME/.poetry/bin
      $HOME/.local/flutter/bin
      /Applications/Tailscale.app/Contents/MacOS
      $HOME/.local/zig
      $HOME/go/bin
      $HOME/.ghcup/bin
      /Applications/Julia-1.5.app/Contents/Resources/julia/bin
      $HOME/.gem/ruby/2.6.0/bin/
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
export CLICOLOR=1

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
      $HOME/Repositories/neovim_development/neovim/result/bin/nvim -u ~/.config/nvim/init_test.lua $@
}

home-upgrade () {
  nix flake update $HOME/Repositories/nix/nix-dotfiles/home-manager
  home-manager switch --flake "/Users/michael/Repositories/nix/nix-dotfiles/home-manager#macbook-pro"
  # (( $+commands[doom] )) && doom -y upgrade
}

home-switch () {
  home-manager switch --flake "/Users/michael/Repositories/nix/nix-dotfiles/home-manager#macbook-pro"
}

system-upgrade () {
   nix flake update $HOME/Repositories/nix/nix-dotfiles/darwin
   darwin-rebuild switch --flake $HOME/Repositories/nix/nix-dotfiles/darwin
}

system-switch () {
   darwin-rebuild switch --flake $HOME/Repositories/nix/nix-dotfiles/darwin
}
