# Where first arg is directory under machines, can be one of macos, fedora, nixos
ln -s $(pwd) $HOME/.config 
ln -s $(pwd)/machines/$1/home.nix $HOME/.config/nixpkgs/home.nix
ln -s $(pwd)/machines/$1/config.nix $HOME/.config/nixpkgs/config.nix
