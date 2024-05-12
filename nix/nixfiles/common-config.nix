# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, lib, ... }:

{

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 30;

  networking.hostName = "nixosDesktop"; # Define your hostname.

  networking.networkmanager.enable =
    lib.mkIf (config.networking.hostName != "nixosDesktop")
    true; # Easiest to use and most distros use this by default.

  # Allow Docker
  virtualisation.docker.enable = true;

  # Set your time zone.
  time.timeZone = "America/Montreal";

  nix.settings.substituters = [
    "https://nix-community.cachix.org"
    "https://cache.nixos.org"
    "https://cuda-maintainers.cachix.org"
  ];

  nix.settings.trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
  ];
  # Automation
  nix.settings.auto-optimise-store = true;

  #Garbage collection
  nix.gc = {
    automatic = true;
    dates = "*-*-* 18:00:00";
    options = "--delete-older-than 14d";
  };

  fonts.fontconfig.enable = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    victor-mono
    fira-code
    fira-code-symbols
    (nerdfonts.override { fonts = [ "FiraCode" "Noto" "VictorMono" ]; })
  ];
  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.

  users.users.simon.isNormalUser = true;
  users.users.simon.extraGroups =
    [ "wheel" "video" "docker"]; # Enable ‘sudo’ for the user.
  users.users.simon.packages = with pkgs; [ ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    rsync
    cmake
    gnumake
    xclip
    gcc
    unzip
    man-pages
    man-pages-posix
    zip
    git
    pinentry
    pass
  ];

  programs.zsh.enable = true;
  users.users.simon.shell = pkgs.zsh;
  nixpkgs.config.allowUnfree = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    settings = { 
      default-cache-ttl = 36000; #10 hours
    };
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

}
