{
  description = "Example home-manager from non-nixos system";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  # inputs.nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

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
      # nixos-unstable-overlay = final: prev: {
      #   nixos-unstable = import inputs.nixos-unstable {
      #     system = prev.system;
      #     # config.allowUnfree = true;
      #     overlays = [ inputs.emacs-overlay.overlay ];
      #   };
      # };
      overlays = [
                  # nixos-unstable-overlay
                (self: super: {
                    opencv4 = super.opencv4.override { enableUnfree = false; enableCuda = false; };
                    blender = super.blender.override { cudaSupport = false; };
                  })
                inputs.emacs-overlay.overlay
                inputs.neovim-nightly-overlay.overlay
                additional-package-overlay
              ] ;
      additional-package-overlay = final: prev: {
        LS_COLORS = inputs.LS_COLORS;
      };
    in
    {
      homeConfigurations = {
        macbook-pro = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, ... }:

            {
              nixpkgs.overlays = overlays;
              imports = [
                ./machines/macbook-pro/home.nix
              ];
            };
          system = "x86_64-darwin";
          homeDirectory = "/Users/michael";
          username = "michael";
        };
        linux-desktop = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, ... }:
            {
              nixpkgs.overlays = overlays;
              imports = [
                ./machines/linux-desktop/home.nix
              ];
            };
          system = "x86_64-linux";
          homeDirectory = "/home/michael";
          username = "michael";
        };
        nixos-desktop = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, ... }:
            {
              nixpkgs.overlays = overlays;
              nixpkgs.config = import ./machines/nixos-desktop/config.nix;
              imports = [
                ./machines/nixos-desktop/home.nix
              ];
            };
          system = "x86_64-linux";
          homeDirectory = "/home/mjlbach";
          username = "mjlbach";
        };
      };
      macbook-pro = self.homeConfigurations.macbook-pro.activationPackage;
      linux-server = self.homeConfigurations.linux-server.activationPackage;
      linux-desktop = self.homeConfigurations.linux-desktop.activationPackage;
      nixos-desktop = self.homeConfigurations.nixos-desktop.activationPackage;
    };
}
