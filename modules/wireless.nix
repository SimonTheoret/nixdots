{ config, lib, ... }:

let
  inherit (lib) mkOption mkIf;
  cfg = config.myWireless;
in {
  options.myWireless = {
    enable = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Activate wireless configuration with NetworkManager" ;
    };
  };
  config = mkIf cfg.enable {
   networking.hostName = "nixos"; # Define your hostname.
   networking.networkmanager.enable = true;  # Gives nmcli and nmtui
  };
}
