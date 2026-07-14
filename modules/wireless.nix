{
  config,
  lib,
  hostName,
  sops,
  ...
}:

let
  inherit (lib) mkOption mkIf;
  cfg = config.myWireless;
in
{
  options.myWireless = {

    enable = mkOption {
      type = lib.types.bool;
      default = false;
      example = false;
      description = "Activate wireless configuration with NetworkManager";
    };
    style = mkOption {
      type = lib.types.enum [
        "declarative"
        "imperative"
      ];
      default = "imperative";
      example = "imperative";
      description = "Configure ";
    };
  };
  config = mkIf cfg.enable {
    networking.hostName = "${hostName}"; # Define your hostname.
    networking.networkmanager.enable = (cfg.style == "imperative"); # Gives nmcli and nmtui
    networking.wireless = mkIf (cfg.style == "declarative") {
      allowAuxiliaryImperativeNetworks = true;
      enable = true;
      networks = {
        "${sops.secrets.wifi_name}" = {
          psk = "${sops.secrets.wifi_password}";
        };
      };
    };

  };
}
