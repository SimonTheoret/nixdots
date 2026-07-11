{
  pkgs,
  lib,
  config,
  ...
}:

let
  inherit (lib) mkOption mkIf optionals;
  cfg = config.myLab;
  plane = (pkgs.callPackage ../packages/plane/plane.nix { });
in
{

  options.myLab = {
    enable = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Configure HomeLab";
    };
    plane = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Configure Plane";
    };
  };

  config = mkIf (cfg.enable && config.myVirtualization.enable) {

    systemd.services.plane = mkIf (cfg.plane) {
      wantedBy = [ "multi-user.target" ];
      after = [
        "docker.service"
        "docker.socket"
      ];
      serviceConfig = {
        ExecStart = "${plane}/bin/plane start";
      };

    };
    environment.systemPackages = [ ] ++ optionals (cfg.plane) [ plane ];

  };
}
