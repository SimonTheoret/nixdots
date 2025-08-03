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
  };

  config = mkIf cfg.enable {
    hardware.bluetooth.enable = true; # enables support for Bluetooth
    hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
    services.blueman.enable = true; # enables gui with blueman
    # services.mpris-proxy.enable = true; # enable headsets buttons #Move that to HM?
  };
}
