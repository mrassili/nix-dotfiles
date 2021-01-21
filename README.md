# My nix dotfiles

nixos contains my nixos configuration, and is symlinked to /etc/nixos

nixpkgs contains my userland nix configuration, and is symlinked to $HOME/.config/nixpkgs via the install script

# To install nix

```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```
# To install cachix

```nix
nix-env -iA cachix -f https://cachix.org/api/v1/install
```

# To install my home-manager configuration

```
git clone https://github.com/mjlbach/nix-dotfiles.git
cd nix-dotfiles/nixpkgs
bash install.sh {linux-desktop, macbook-pro, linux-server, nixos-desktop}`
```

# To install my NixOS configuration
```
git clone https://github.com/mjlbach/nix-dotfiles.git
cd nix-dotfiles/nixos
nix-shell -p nixFlakes
bash install.sh
```
