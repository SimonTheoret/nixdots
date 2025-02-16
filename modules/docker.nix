{
  config,
  pkgs,
  lib,
  userName,
  ...
}:

let
  inherit (lib) mkOption mkIf;
  cfg = config.myDocker;
  inherit userName;
in
{
  options.myDocker = {

    enable = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Configure Docker and Docker-Compose";
    };
  };

  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;
    hardware.nvidia-container-toolkit.enable = config.myNvidia.enable;

    hardware.graphics.enable32Bit = config.myNvidia.enable; # Necessary for enableNvidia

    virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };
    environment.systemPackages = with pkgs; [
      docker-compose
    ];
  };
}
