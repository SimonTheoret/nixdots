{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) mkOption mkIf;
  cfg = config.mySpotify;
in
{
  options.mySpotify = {
    enable = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "activate spotify";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = pkgs.lib.optionals (cfg.enable) [
      pkgs.spotify
    ];
  };
}
