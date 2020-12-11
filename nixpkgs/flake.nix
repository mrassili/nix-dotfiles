{
  description = "Example home-manager from non-nixos system";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  # inputs.nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.flake-compat = {
    url = "github:edolstra/flake-compat";
    flake = false;
  };

  inputs.neovim-nightly-overlay.url = "github:mjlbach/neovim-nightly-overlay";
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
      config = {
        allowUnfree = true;
        cudaSupport = true;
        experimental-features = "nix-command flakes";
        keep-derivations = true;
        keep-outputs = true;
        firefox.enablePlasmaBrowserIntegration = true;
      };
      overlays = [
        # nixos-unstable-overlay
        (self: super: {
          opencv4 = super.opencv4.override { enableUnfree = false; enableCuda = false; };
          blender = super.blender.override { cudaSupport = false; };
        })
        inputs.emacs-overlay.overlay
        inputs.neovim-nightly-overlay.overlay
       (final: prev: {LS_COLORS = inputs.LS_COLORS; })
      ];
    in
    {
      homeConfigurations = {
        macbook-pro = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, ... }:

            {
              nixpkgs.config = config;
              nixpkgs.overlays = overlays;
              imports = [
                ./modules/cli.nix
                ./modules/emacs.nix
                ./modules/git.nix
                ./modules/home-manager.nix
                ./modules/neovim.nix
                ./modules/nix-utilities.nix
                ./modules/ssh.nix
                ./modules/weechat.nix
              ];

              programs.zsh = {
                enable = true;
                enableCompletion = false;
                initExtraBeforeCompInit = builtins.readFile ./configs/zsh/macbook-pro_zshrc.zsh;
                initExtra = ''
                  source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
                  source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/config/p10k-lean.zsh
                '';
              };
            };
          system = "x86_64-darwin";
          homeDirectory = "/Users/michael";
          username = "michael";
        };
        linux-desktop = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, ... }:
            {
              nixpkgs.config = config;
              nixpkgs.overlays = overlays;
              imports = [
                ./modules/cli.nix
                ./modules/emacs.nix
                ./modules/git.nix
                ./modules/home-manager.nix
                ./modules/languages.nix
                ./modules/neovim.nix
                ./modules/nix-utilities.nix
                ./modules/ssh.nix
              ];

              programs.zsh = {
                enable = true;
                enableCompletion = false;
                initExtraBeforeCompInit = builtins.readFile ../../configs/zsh/linux-desktop_zshrc.zsh;
                initExtra = ''
                  source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
                  source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/config/p10k-lean.zsh
                '';
              };

              xdg.configFile."alacritty/alacritty.yml".source = ../../configs/terminal/alacritty.yml;
            };
          system = "x86_64-linux";
          homeDirectory = "/home/michael";
          username = "michael";
        };
        linux-server = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, ... }:
            {
              nixpkgs.config = config;
              nixpkgs.overlays = overlays;
              imports = [
                ./modules/home-manager.nix
                ./modules/cli.nix
                ./modules/neovim.nix
                ./modules/git.nix
                ./modules/nix-utilities.nix
              ];

              programs.zsh = {
                enable = true;
                enableCompletion = false;
                initExtraBeforeCompInit = builtins.readFile ../../configs/zsh/linux-desktop_zshrc.zsh;
                initExtra = ''
                  source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
                  source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/config/p10k-lean.zsh
                '';
              };
          };
          system = "x86_64-linux";
          homeDirectory = "/home/mjlbach";
          username = "mjlbach";
        };
        nixos-desktop = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, ... }:
            {
              nixpkgs.config = config;
              nixpkgs.overlays = overlays;
              imports = [
                ./modules/home-manager.nix
                ./modules/alacritty.nix
                ./modules/chat.nix
                ./modules/cli.nix
                ./modules/cuda.nix
                ./modules/git.nix
                ./modules/media.nix
                ./modules/nix-utilities.nix
                ./modules/nixos-desktop.nix
                ./modules/python.nix
                ./modules/ssh.nix
                ./modules/languages.nix
                ./modules/neovim.nix
                ./modules/emacs.nix
              ];

              programs.zsh = {
                enable = true;
                enableCompletion = false;
                initExtraBeforeCompInit = builtins.readFile ../../configs/zsh/nixos-desktop_zshrc.zsh;
                initExtra = ''
                  source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
                  source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/config/p10k-lean.zsh
                '';
              };

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
