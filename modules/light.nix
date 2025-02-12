{ config, lib, ... }:

let
  inherit (lib) mkOption mkIf;
  cfg = config.myLight;
in {
  options.myLight = {
    enable = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Activate backlight control with light" ;
    };
  };
  config = mkIf cfg.enable {
    programs.light = {
      enable = true;
      brightnessKeys = {
        enable = true;
        step = 3;
      };
    };
  };

}
