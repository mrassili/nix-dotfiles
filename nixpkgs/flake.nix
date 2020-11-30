{
  description = "Example home-manager from non-nixos system";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.flake-compat = {
    url = "github:edolstra/flake-compat";
    flake = false;
  };

  inputs.neovim-nightly-overlay.url = "github:mjlbach/neovim-nightly-overlay/flakes";
  inputs.emacs-overlay = {
    type = "github";
    owner = "mjlbach";
    repo = "emacs-overlay";
    ref = "feature/version_nixpkgs_flake_limited";
  };

  inputs.home-manager = {
    url = "github:rycee/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  inputs.LS_COLORS = {
    url = "github:trapd00r/LS_COLORS";
    flake = false;
  };

  outputs = { self, ... }@inputs:
    let
      nixos-unstable-overlay = final: prev: {
        nixos-unstable = import inputs.nixos-unstable {
          system = prev.system;
          # config.allowUnfree = true;
          overlays = [ inputs.emacs-overlay.overlay ];
        };
      };
      additional-package-overlay = final: prev: {
        LS_COLORS = inputs.LS_COLORS;
      };
    in
    {
      homeConfigurations = {
        macbook-pro = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, ... }:

            {
              nixpkgs.overlays = [
                nixos-unstable-overlay
                inputs.emacs-overlay.overlay
                inputs.neovim-nightly-overlay.overlay
                additional-package-overlay
              ];
              imports = [
                ./machines/macos/home.nix
              ];
            };
          system = "x86_64-darwin";
          homeDirectory = "/Users/michael";
          username = "michael";
        };
        linux = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, ... }:
            {
              nixpkgs.overlays = [
                nixos-unstable-overlay
                inputs.emacs-overlay.overlay
                inputs.neovim-nightly-overlay.overlay
                additional-package-overlay
              ];
              imports = [
                ./machines/linux/home.nix
              ];
            };
          system = "x86_64-linux";
          homeDirectory = "/Users/mjlbach";
          username = "mjlbach";
        };
        nixos = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, ... }:
            {
              nixpkgs.overlays = [
                nixos-unstable-overlay
                inputs.emacs-overlay.overlay
                inputs.neovim-nightly-overlay.overlay
                additional-package-overlay
              ];
              imports = [
                ./machines/linux/home.nix
              ];
            };
          system = "x86_64-linux";
          homeDirectory = "/Users/mjlbach";
          username = "mjlbach";
        };
      };
      macbook-pro = self.homeConfigurations.macbook-pro.activationPackage;
      linux = self.homeConfigurations.linux.activationPackage;
      nixos = self.homeConfigurations.nixos.activationPackage;
    };
}
