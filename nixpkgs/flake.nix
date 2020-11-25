{
  description = "A flake for home-manager-template";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.home-manager = {
    url = "github:rycee/home-manager";
    inputs.nixpkgs.follows = "";
  };
  inputs.flake-compat = {
    url = "github:edolstra/flake-compat";
    flake = false;
  };
  inputs.emacs-overlay.url = "github:nix-community/emacs-overlay";
  inputs.powerlevel10k = {
    url = "github:romkatv/powerlevel10k";
    flake = false;
  };
  inputs.LS_COLORS = {
    url = "github:trapd00r/LS_COLORS";
    flake = false;
  };
  inputs.neovim-nightly-overlay = {
    url = "github:mjlbach/neovim-nightly-overlay";
    flake = false;
  };
  inputs.emacs-pgtk-overlay = {
    url = "github:mjlbach/emacs-pgtk-nativecomp-overlay";
    flake = false;
  };

  outputs = inputs@{ self, flake-utils, nixpkgs, nixos-unstable, home-manager, ... }: with inputs;
    flake-utils.lib.eachDefaultSystem (system:
    let 
      pkgs = nixpkgs.legacyPackages.${system}; 
      pkgs-nixos-unstable = nixos-unstable.legacyPackages.${system}; 
    in
      {
        packages.nixpkgs-unstable = pkgs;
        packages.nixos-unstable = pkgs-nixos-unstable;
        devShell = pkgs.mkShell rec {

          name = "home-manager-shell";

          buildInputs = with pkgs; [
            cachix
            (import home-manager { inherit pkgs; }).home-manager
          ];

          shellHook = ''
            export NIX_PATH="nixpkgs=${nixpkgs}:home-manager=${home-manager}"
            export HOME_MANAGER_CONFIG="$HOME/.config/nixpkgs/home.nix"
            PS1="${name}> "
          '';
        };
      });
}
