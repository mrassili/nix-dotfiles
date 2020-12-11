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
