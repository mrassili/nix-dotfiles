{ config, pkgs, libs, ... }:
let
  sources = import ../../nix/sources.nix;
  pkgs = import sources.nixpkgs-unstable { };
  nixos-unstable = import sources.nixos-unstable { };
  powerlevel10k = pkgs.fetchFromGitHub {
    owner = "romkatv";
    repo = "powerlevel10k";
    # nixos-unstable as of 2017-11-13T08:53:10-00:00
    rev = "b7d90c84671183797bdec17035fc2d36b5d12292";
    sha256 = "0nzvshv3g559mqrlf4906c9iw4jw8j83dxjax275b2wi8ix0wgmj";
  };
in

{
  home.sessionVariables = {
    LOCALE_ARCHIVE = "${pkgs.glibcLocales.override {allLocales = false;}}/lib/locale/locale-archive";
  };
  # Let Home Manager install and manage itself.
  imports = [
    ../../modules/cli.nix
    ../../modules/cuda.nix
    ../../modules/editors.nix
    ../../modules/git.nix
    ../../modules/nix-utilities.nix
    # ../../modules/python.nix
    ../../modules/ssh.nix
  ];

  home.packages = with pkgs; [
      mu
      isync
    ];

  programs.zsh = {
    enable = true;
    enableCompletion = false;
    initExtraBeforeCompInit = builtins.readFile ../../configs/zsh/fedora_zshrc.zsh;
    plugins = [{
      name = "powerlevel10k";
      # src = pkgs.fetchFromGitHub {
      #   inherit (sources.powerlevel10k) owner repo rev sha256;
      # };
      src = powerlevel10k;
    }];
  };

  programs.emacs = {
    enable = true;
    package = nixos-unstable.emacsGcc;
    extraPackages = (epkgs: [ epkgs.vterm] );
  };

  xdg.configFile."alacritty/alacritty.yml".source = ../../configs/terminal/alacritty.yml;
  services.lorri.enable = true;
  programs.home-manager.enable = true;
  programs.bash.enable = true;

  # services.emacs.client.enable = true;
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.03";
}
