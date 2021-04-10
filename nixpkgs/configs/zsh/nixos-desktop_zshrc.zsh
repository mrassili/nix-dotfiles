typeset -U path
path=(
      $HOME/.config/emacs/bin
      $path
    )

# initialize keychain: This can go below instant prompt so long as -q is enabled and --eval is disabled
eval $(keychain -q --eval)

home-upgrade () {
  nix flake update $HOME/.config/nixpkgs
  home-manager switch --flake "$HOME/.config/nixpkgs#nixos-desktop"
  # (( $+commands[doom] )) && doom -y upgrade
}

home-switch () {
  home-manager switch --flake "$HOME/.config/nixpkgs#nixos-desktop"
}

system-upgrade () {
  sudo nix flake update /etc/nixos
  sudo nixos-rebuild switch --flake '/etc/nixos#nixos-desktop'
}

system-switch () {
  sudo nixos-rebuild switch --flake '/etc/nixos#nixos-desktop'
}
