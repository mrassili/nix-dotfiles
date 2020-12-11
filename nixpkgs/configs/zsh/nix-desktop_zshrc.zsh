# initialize keychain: This can go below instant prompt so long as -q is enabled and --eval is disabled
eval $(keychain -q --eval)

home-upgrade () {
  nix flake update $HOME/.config/nixpkgs --recreate-lock-file
  nix build "$HOME/.config/nixpkgs#nixos" -o "$HOME/.config/nixpkgs/result"
  (( $+commands[doom] )) && doom -y upgrade
}

home-switch () {
  nix build "$HOME/.config/nixpkgs#nixos" -o "$HOME/.config/nixpkgs/result"
}

system-upgrade () {
  nix flake update /etc/nixos --recreate-lock-file
  sudo nixos-rebuild switch --flake '/etc/nixos#nixos-desktop'
}

system-switch () {
  nix flake update /etc/nixos --recreate-lock-file
  sudo nixos-rebuild switch --flake '/etc/nixos#nixos-desktop'
}
