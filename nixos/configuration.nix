{ config, lib, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Use 5.10 kernel.
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

  # Use performance cpu governor.
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

  # Enable networking.
  networking.hostName = "nixos-desktop";
  networking.networkmanager.enable = true;
  networking.resolvconf.dnsExtensionMechanism = false;

  # Set system fonts.
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

  # Enable early oom.
  services.earlyoom.enable = true;

  # Packages installed in system profile.
  environment.systemPackages = with pkgs; [
    git
    latte-dock
    unzip
    vim
    wget
  ];

  # Configure the nix package manager.
  nix = {
    package = pkgs.nixFlakes;
    maxJobs = lib.mkDefault 24;
    autoOptimiseStore = true;
    trustedUsers = [ "root" "mjlbach" "@wheel" ];
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Allow unfree packages from nixpkgs.
  nixpkgs.config.allowUnfree = true;

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

  virtualisation.podman = {
    enable = true;
    enableNvidia = true;
  };

  # Enable gnome-keyring for geary.
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  # Enable flatpaks.
  services.flatpak.enable = true;

  # services.dendrite.enable = true;
  # services.dendrite.privateKey="/home/mjlbach/matrix_key.pem";
  # services.dendrite.settings.global.private_key="/home/mjlbach/matrix_key.pem";
  # services.dendrite.settings.global.server_name="test-server";

  # Define a user account.
  users.users.mjlbach = {
    isNormalUser = true;
    createHome = true;
    uid = 1000;
    extraGroups = [ "wheel" "video" "networkmanager" "vboxusers" "docker" ];
    shell = pkgs.zsh;
  };

  system.stateVersion = "21.05";

}
