ln -s $(pwd) /etc/nixos
sudo nixos-rebuild switch --flake '/etc/nixos#nixos-desktop'
