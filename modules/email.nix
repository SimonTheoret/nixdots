{ config, pkgs, lib, ... }:

let
  inherit (lib) mkOption mkIf;
  cfg = config.myEmail;
in {
  options.myEmail = {
    enable = mkOption {
      type = lib.types.bool;
      default = false;
      example = true; description = "Setup email applications" ;
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      isync
      msmtp
    ]
    ++ pkgs.lib.optionals (cfg.useGUI) [thunderbird];
  };
}
