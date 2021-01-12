# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Use 5.10 kernel
  boot.kernelPackages = pkgs.linuxPackages_5_10;

  # Use the systemd-boot EFI boot loader.
  boot.supportedFilesystems = [ "ntfs" ];
  boot.loader = {
    systemd-boot.enable = false;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      enable = true;
      version = 2;
      device = "nodev";
      efiSupport = true;
      useOSProber = false;
      extraEntries = ''
        menuentry "Windows Boot Manager (on /dev/nvme0n1p2)" --class windows --class os {
          insmod part_gpt
          insmod fat
          search --no-floppy --fs-uuid --set=root 40E2-A3BF
          chainloader /EFI/Microsoft/Boot/bootmgfw.efi
        }

        menuentry "Fedora" --class fedora --class os {
          insmod part_gpt
          insmod ext2
          insmod fat
          search --no-floppy --fs-uuid --set=root 40E2-A3BF
          chainloader /EFI/fedora/grubx64.efi
        }
      '';
    };
  };

  # Enable networking
  networking.hostName = "nixos-desktop";
  networking.networkmanager.enable = true;
  networking.resolvconf.dnsExtensionMechanism = false;

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      ubuntu_font_family
    ];
    fontconfig.defaultFonts = {
      sansSerif = [ "Ubuntu" ];
      monospace = [ "Ubuntu Mono" ];
    };
  };
  # Set your time zone.
  services.localtime.enable = true;

  # Enable early oom
  services.earlyoom.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    kdeApplications.knotes
    latte-dock
    unzip
    vim
    wget
  ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
   };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.ports = [ 5037 ];
  services.openssh.passwordAuthentication = false;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.screenSection = ''
    Option "NoFlip" "true"
  '';

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm = {
    enable = true;
    enableHidpi = true;
  };
  services.xserver.desktopManager.plasma5.enable = true;

  # Enable nvidia with modesetting.
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
  };

  # Enable OpenGL.
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
    setLdLibraryPath = true;
  };

  # Enable Docker.
  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
  };

  # Enable for geary.
  # programs.dconf.enable = true;
  services.gnome3.gnome-keyring.enable = true;
  services.gnome3.gnome-online-accounts.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  # Enable flatpaks.
  services.flatpak.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mjlbach = {
    isNormalUser = true;
    createHome = true;
    uid = 1000;
    extraGroups = [ "wheel" "video" "networkmanager" "vboxusers" "docker" ];
    shell = pkgs.zsh;
  };

  nix = {
    autoOptimiseStore = true;
    trustedUsers = [ "root" "mjlbach" "@wheel" ];
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "21.03";

}
