typeset -U path
path=(
      $HOME/.config/emacs/bin
      $path
    )

# initialize keychain: This can go below instant prompt so long as -q is enabled and --eval is disabled
eval $(keychain -q --eval)

home-upgrade () {
  nix flake update $HOME/.config/nixpkgs --recreate-lock-file
  nix build "$HOME/.config/nixpkgs#nixos-desktop" -o "$HOME/.config/nixpkgs/result"
  zsh "$HOME/.config/nixpkgs/result/activate"
  (( $+commands[doom] )) && doom -y upgrade
}

home-switch () {
  nix build "$HOME/.config/nixpkgs#nixos-desktop" -o "$HOME/.config/nixpkgs/result"
  zsh "$HOME/.config/nixpkgs/result/activate"
}

system-upgrade () {
  sudo nix flake update /etc/nixos --recreate-lock-file
  sudo nixos-rebuild switch --flake '/etc/nixos#nixos-desktop'
}

system-switch () {
  sudo nixos-rebuild switch --flake '/etc/nixos#nixos-desktop'
}
