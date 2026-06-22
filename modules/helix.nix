{
  config,
  lib,
  pkgsUnstable,
  # inputs,
  ...
}:
let
  # helix-master = inputs.helix-master;
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
      pkgsUnstable.helix
      # helix-master.helix.packages.
      # helix-master.packages.${pkgsUnstable.stdenv.hostPlatform.system}.default
    ];
  };
}
