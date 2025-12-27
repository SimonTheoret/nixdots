{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.myBluetooth;
in
{
  imports = [ ];
  options.myBluetooth = {
    enable = pkgs.lib.mkOption {
      type = pkgs.lib.types.bool;
      default = false;
      example = true;
      description = "Activate bluetooth";
    };
    driver = pkgs.lib.mkOption {
      type = pkgs.lib.types.bool;
      default = false;
      example = true;
      description = "Activate rtl8821ce driver";
    };
  };

  config = mkIf cfg.enable {
    hardware.bluetooth.enable = true; # enables support for Bluetooth
    hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
    services.blueman.enable = true; # enables gui with blueman
    hardware.bluetooth.settings = {
      General = {
        # Shows battery charge of connected devices on supported
        # Bluetooth adapters. Defaults to 'false'.
        Experimental = true;
        # When enabled other devices can connect faster to us, however
        # the tradeoff is increased power consumption. Defaults to
        # 'false'.
        FastConnectable = true;
      };
      Policy = {
        # Enable all controllers when they are found. This includes
        # adapters present on start as well as adapters that are plugged
        # in later on. Defaults to 'true'.
        AutoEnable = true;
      }; # services.mpris-proxy.enable = true; # enable headsets buttons #Move that to HM?
    };
    # Add bluez, the official linux bluetooth protocol stack:
    environment.systemPackages =
      with pkgs;
      [ bluez ] ++ pkgs.lib.optionals (cfg.driver) [ linuxKernel.packages.linux_6_12.rtl8821ce ];
  };
}
