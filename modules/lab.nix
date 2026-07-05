{
  config,
  pkgs,
  lib,
  pkgsUnstable,
  ...
}:

let
  inherit (lib) mkOption mkIf;
  cfg = config.myLab;
in
{
  options.myLab = {
    enable = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Configure the Lab";
    };
  };

  config = mkIf cfg.enable { };
}
