typeset -U path
path=(
      $HOME/.config/emacs/bin
      $path
    )

# Prompt aliases
alias ls="ls --color=auto"
alias ll="ls -alh --color=auto"
alias l="ls --color=auto"

# Colorize terminal
eval $( dircolors -b $HOME/.config/dircolors )

home-upgrade () {
  nix flake update $HOME/.config/nixpkgs
  home-manager switch --flake "$HOME/Repositories/nix/nix-dotfiles/home-manager#nixos-desktop"
  # (( $+commands[doom] )) && doom -y upgrade
}

home-switch () {
  home-manager switch --flake "$HOME/Repositories/nix/nix-dotfiles/home-manager#nixos-desktop"
}

system-upgrade () {
  sudo nix flake update /etc/nixos
  sudo nixos-rebuild switch --flake '/etc/nixos#nixos-desktop'
}

system-switch () {
  sudo nixos-rebuild switch --flake '/etc/nixos#nixos-desktop'
}
