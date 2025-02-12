{config, pkgs, inputs, ...}:
{
  options.myBluetooth = {
    enable = pkgs.lib.mkOption {
      type = pkgs.lib.types.bool;
      default = false;
      example = true;
      description = "Activate bluetooth";
    };
    guiControls = pkgs.lib.mkOption {
      type = pkgs.lib.types.bool;
      default = false;
      example = true;
      description = "Use blueman-manager in a GUI to configure bluetooth";
    };
  };

  config = pkgs.lib.mkIf config.myBluetooth.enable {
    hardware.bluetooth.enable = true; # enables support for Bluetooth
    hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
    services.blueman.enable = config.myUi.useGUI; # enables gui with blueman
    services.mpris-proxy.enable = true; # enable headsets buttons
  };
}
