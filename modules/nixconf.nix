{
  config,
  lib,
  ...
}:

let
  inherit (lib) mkOption mkIf;
  cfg = config.myBootLoader;
in
{
  options.myBootLoader = {
    enable = mkOption {
      type = lib.types.bool;
      default = true;
      example = false;
      description = "Configure Systemd bootloader";
    };

  };

  config = {
    nix.settings.substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos.org"
      "https://cuda-maintainers.cachix.org"
      "https://hyprland.cachix.org"
    ];

    nix.settings.trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];

    nixpkgs.config.allowUnfree = true;
    time.timeZone = "America/Montreal";
    networking.hostName = "nixos"; # Define your hostname.
    boot.loader.systemd-boot.enable = mkIf cfg.enable true;
    boot.loader.efi.canTouchEfiVariables = mkIf cfg.enable true;
    boot.loader.systemd-boot.configurationLimit = mkIf cfg.enable 30;
    system.stateVersion = "24.11"; # Did you read the comment?
    services.openssh.enable = true;

    #flakes
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    # Automation
    nix.settings.auto-optimise-store = true;

    #Garbage collection
    nix.gc = {
      automatic = true;
      dates = "*-*-* 18:00:00";
      options = "--delete-older-than 14d";
    };

    environment.variables = {
      NIX_CONFIG = "download-buffer-size = 335544320";
    };
    nix.settings.trusted-users = ["root" "@wheel"];
  };

}
