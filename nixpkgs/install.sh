# Where first arg is directory under machines, can be one of macos, fedora, nixos
mkdir -p $HOME/.config
ln -s $(pwd) $HOME/.config/nixpkgs 
ln -s $(pwd)/machines/$1/config.nix $HOME/.config/nixpkgs/config.nix
