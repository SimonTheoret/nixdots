{
  config,
  lib,
  pkgsUnstable,
  helix-master,
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
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      # helix-master.helix.packages.
      helix-master.packages.${pkgsUnstable.stdenv.hostPlatform.system}.default
    ];
  };
}
