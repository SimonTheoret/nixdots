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
  searxng = (pkgs.callPackage ../packages/searxng/searxng.nix { });
  appflowy = (pkgs.callPackage ../packages/appflowy/appflowy.nix { });
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
    searxng = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Configure Searxng";
    };
    appflowy = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Configure appflowy";
    };
  };

  config = mkIf (cfg.enable && config.myVirtualisation.enable) {

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
    systemd.services.searxng = mkIf (cfg.searxng) {
      wantedBy = [ "multi-user.target" ];
      after = [
        "docker.service"
        "docker.socket"
      ];
      serviceConfig = {
        ExecStart = "${searxng}/bin/searxng -v start";
      };

    };
    systemd.services.appflowy = mkIf (cfg.appflowy) {
      wantedBy = [ "multi-user.target" ];
      after = [
        "docker.service"
        "docker.socket"
      ];
      serviceConfig = {
        ExecStart = "${appflowy}/bin/appflowy -v start";
      };
    };

    environment.systemPackages =
      [ ]
      ++ optionals (cfg.plane) [ plane ]
      ++ optionals (cfg.searxng) [ searxng ]
      ++ optionals (cfg.appflowy) [ appflowy ];

  };
}
