{
  description = "Example home-manager from non-nixos system";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  # inputs.nixpkgs.url = "path:/home/michael/Repositories/nix/nixpkgs";
  # inputs.nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

  inputs.neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

  inputs.emacs-overlay = {
    type = "github";
    owner = "mjlbach";
    repo = "emacs-overlay";
    # rev = "d62b49ac651e314080e333a7e1f190877675ee99";
    # url = "path:/Users/michae/Repositories/emacs-overlay";
    ref = "feature/flakes";
  };

  inputs.home-manager = {
    url = "github:nix-community/home-manager";
    # url = "path:/Users/michael/Repositories/nix/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  inputs.telescope-fzf-native = {
    url = "github:nvim-telescope/telescope-fzf-native.nvim";
    flake = false;
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
          telescope-fzf-native = super.callPackage ./packages/telescope-fzf-native.nix {src = inputs.telescope-fzf-native;};
        })
        (self: super: {
          opencv4 = super.opencv4.override { enableUnfree = false; enableCuda = false; };
          blender = super.blender.override { cudaSupport = false; };
        })
        (self: super: {
          zsh-powerlevel10k = super.callPackage ./packages/powerlevel10k.nix {};
        })
        inputs.emacs-overlay.overlay
        inputs.neovim-nightly-overlay.overlay
        (final: prev: { LS_COLORS = inputs.LS_COLORS; })
      ];
    in
    {
      homeConfigurations = {
        macbook-pro = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, config, ... }:
            {
              xdg.configFile."nix/nix.conf".source = ./configs/nix/nix.conf;
              nixpkgs.config = import ./configs/nix/config.nix;
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
              programs.zsh.initExtra = builtins.readFile ./configs/zsh/macbook-pro_zshrc.zsh;
              # xdg.configFile."terminfo".source = ./configs/terminfo/terminfo_mac;
            };
          system = "x86_64-darwin";
          homeDirectory = "/Users/michael";
          username = "michael";
        };
        linux-desktop = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, ... }:
            {
              xdg.configFile."nix/nix.conf".source = ./configs/nix/nix.conf;
              nixpkgs.config = import ./configs/nix/config.nix;
              nixpkgs.overlays = overlays;
              imports = [
                ./modules/cli.nix
                ./modules/emacs.nix
                ./modules/git.nix
                ./modules/home-manager.nix
                ./modules/languages.nix
                ./modules/neovim.nix
                ./modules/nix-utilities.nix
                ./modules/linux-only.nix
                ./modules/ssh.nix
              ];

              programs.zsh.initExtra = builtins.readFile ./configs/zsh/linux-desktop_zshrc.zsh;
              xdg.configFile."alacritty/alacritty.yml".source = ./configs/terminal/alacritty.yml;
            };
          system = "x86_64-linux";
          homeDirectory = "/home/michael";
          username = "michael";
        };
        wsl = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, ... }:
            {
              xdg.configFile."nix/nix.conf".source = ./configs/nix/nix.conf;
              nixpkgs.config = import ./configs/nix/config.nix;
              nixpkgs.overlays = overlays;
              imports = [
                ./modules/cli.nix
                ./modules/emacs.nix
                ./modules/git.nix
                ./modules/home-manager.nix
                ./modules/languages.nix
                ./modules/neovim.nix
                ./modules/nix-utilities.nix
                ./modules/linux-only.nix
                ./modules/ssh.nix
              ];

              programs.zsh.initExtra = builtins.readFile ./configs/zsh/wsl_zshrc.zsh;
              xdg.configFile."alacritty/alacritty.yml".source = ./configs/terminal/alacritty.yml;
            };
          system = "x86_64-linux";
          homeDirectory = "/home/mjlbach";
          username = "mjlbach";
        };
        linux-server = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, ... }:
            {
              xdg.configFile."nix/nix.conf".source = ./configs/nix/nix.conf;
              nixpkgs.config = import ./configs/nix/config.nix;
              nixpkgs.overlays = overlays;
              imports = [
                ./modules/home-manager.nix
                ./modules/cli.nix
                ./modules/neovim.nix
                ./modules/git.nix
                ./modules/linux-only.nix
                ./modules/nix-utilities.nix
              ];
              programs.zsh.initExtra = builtins.readFile ./configs/zsh/linux-server_zshrc.zsh;
            };
          system = "x86_64-linux";
          homeDirectory = "/home/mjlbach";
          username = "mjlbach";
        };
        nixos-desktop = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, ... }:
            {
              xdg.configFile."nix/nix.conf".source = ./configs/nix/nix.conf;
              nixpkgs.config = import ./configs/nix/config.nix;
              nixpkgs.overlays = overlays;
              imports = [
                ./modules/home-manager.nix
                ./modules/alacritty.nix
                ./modules/chat.nix
                ./modules/cli.nix
                # ./modules/cuda.nix
                ./modules/git.nix
                ./modules/media.nix
                ./modules/nix-utilities.nix
                ./modules/nixos-desktop.nix
                ./modules/python.nix
                ./modules/ssh.nix
                ./modules/languages.nix
                ./modules/linux-only.nix
                ./modules/neovim.nix
                ./modules/emacs.nix
              ];
              programs.zsh.initExtra = builtins.readFile ./configs/zsh/nixos-desktop_zshrc.zsh;
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
