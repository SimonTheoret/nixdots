{
  config,
  lib,
  pkgsUnstable,
  ...
}:

let
  inherit (lib) mkOption mkIf;
  cfg = config.myVirtualization;
in
{
  options.myVirtualization = {

    enable = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Configure Docker, Docker-Compose and Podman";
    };
  };

  config = mkIf cfg.enable {

    virtualisation.podman = {
      enable = true;
      autoPrune.enable = true;
    };

    virtualisation.docker = {
      enable = true;
      package = pkgsUnstable.docker;
    };
    hardware.nvidia-container-toolkit.enable = config.myNvidia.enable;

    hardware.graphics.enable32Bit = config.myNvidia.enable; # Necessary for enableNvidia

    # virtualisation.docker.rootless = {
    #   enable = true;
    #   setSocketVariable = true;
    # };
    environment.systemPackages = with pkgsUnstable; [
      docker-compose
    ];
  };
}
