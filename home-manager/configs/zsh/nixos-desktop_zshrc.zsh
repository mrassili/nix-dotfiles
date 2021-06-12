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
  nix flake update /nix-dotfiles/home-manager
  home-manager switch --flake "/nix-dotfiles/home-manager#nixos-desktop"
  # (( $+commands[doom] )) && doom -y upgrade
}

home-switch () {
  home-manager switch --flake "/nix-dotfiles/home-manager#nixos-desktop"
}

system-upgrade () {
  sudo nix flake update /nix-dotfiles/nixos
  sudo nixos-rebuild switch --flake '/nix-dotfiles/nixos#nixos-desktop'
}

system-switch () {
  sudo nixos-rebuild switch --flake '/nix-dotfiles/nixos#nixos-desktop'
}
