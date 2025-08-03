{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkOption mkIf;
  cfg = config.myHelix;
in
{
  options.mySync = {
    enable = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Configure RClone for sync";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      rclone
      cron
    ];
  };
}
