# Where first arg is directory under machines, can be one of macos, fedora, nixos
mkdir -p $HOME/.config
ln -s $(pwd) $HOME/.config
nix-shell -p nixUnstable --command "nix build --experimental-features 'nix-command flakes' '.#$1'"
