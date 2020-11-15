# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # ./modules/sync/dropbox.nix
    ];

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

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.interfaces.enp0s31f6.useDHCP = true;
  # networking.interfaces.wlp2s0.useDHCP = true;
  networking.networkmanager.enable = true;
  networking.resolvconf.dnsExtensionMechanism = false;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      ubuntu_font_family
      fira-code
      fira-code-symbols
    ];
    fontconfig.defaultFonts = {
      sansSerif = [ "Ubuntu" ];
      monospace = [ "Fira Code" ];
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
    ntfs3g
    kdeApplications.knotes
    os-prober
    plasma-browser-integration
    unzip
    vim
    wget
    xdg-desktop-portal-kde
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.ports = [ 5037 ];
  services.openssh.passwordAuthentication = false;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

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
  # Old but deprecated settings
  # Option "metamodes" "nvidia-auto-select +0+0 { ForceCompositionPipeline = On }"
  # Option         "AllowIndirectGLXProtocol" "off"
  # Option         "TripleBuffer" "on"

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm = {
    enable = true;
    enableHidpi = true;
  };
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
  };

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
    setLdLibraryPath = true;
  };

  # Enable Docker
  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
  };

  # Enable podman uid mappings
  # virtualisation.containers.enable = true;
  # virtualisation.containers.users = [ "mjlbach" ];

  # Compatibility with geary
  programs.dconf.enable = true;
  services.gnome3.gnome-keyring.enable = true;
  services.gnome3.gnome-online-accounts.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  # Enable flatpaks
  services.flatpak.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mjlbach = {
    isNormalUser = true;
    createHome = true;
    uid = 1000;
    extraGroups = [ "wheel" "video" "networkmanager" "vboxusers" "docker" ];
    shell = pkgs.zsh;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  nix = {
    autoOptimiseStore = true;
    trustedUsers = [ "root" "mjlbach" "@wheel" ];
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "20.03"; # Did you read the comment?

}
