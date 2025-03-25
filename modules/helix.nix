{
  config,
  lib,
  pkgsUnstable,
  ...
}:
let
  inherit (lib) mkOption mkIf;
  cfg = config.myHelix;
in
{
  options.myHelix = {
    enable = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Configure Helix for development";
    };
    mainEditor = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Configure Helix to be the main editor";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgsUnstable; [
      helix
    ];
    
    environment.variables = mkIf cfg.mainEditor {
      EDITOR = "hx";
    };
  };
}
