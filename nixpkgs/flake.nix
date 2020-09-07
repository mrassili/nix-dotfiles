{
  description = "A flake for home-manager-template";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.home-manager = {
    url = "github:rycee/home-manager";
    inputs.nixpkgs.follows = "";
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

  outputs = { self, flake-utils, nixpkgs, home-manager }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      {
        devShell = pkgs.mkShell rec {

          name = "home-manager-template-shell";

          buildInputs = with pkgs; [
            (import home-manager { inherit pkgs; }).home-manager
          ];

          shellHook = ''
            export NIX_PATH="nixpkgs=${nixpkgs}:home-manager=${home-manager}"
            export HOME_MANAGER_CONFIG="./home.nix"
            PS1="${name}> "
          '';
        };
      });
}
