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

    environment.systemPackages =
      [ ] ++ optionals (cfg.plane) [ plane ] ++ optionals (cfg.searxng) [ searxng ];

  };
}
