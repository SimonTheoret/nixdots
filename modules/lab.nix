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
      description = "Configure Appflowy";
    };
    tailscale = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Configure Tailscale";
    };
    gitea = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Configure Gitea";
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
    services.tailscale = mkIf (cfg.tailscale) {
      enable = true;
    };

    services.gitea = mkIf (cfg.gitea) {
      enable = true;
      database = {
        type = "sqlite";
      };
      settings = {
        server.PROTOCOL = "http+unix";
        server.ROOT_URL = "https://git.mezon.com/";
        server.DOMAIN = "git.mezon.com";
      };
    };
    environment.systemPackages =
      [ ]
      ++ optionals (cfg.plane) [ plane ]
      ++ optionals (cfg.searxng) [ searxng ]
      ++ optionals (cfg.appflowy) [ appflowy ];

  };
}
