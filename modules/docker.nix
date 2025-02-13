{ config, pkgs, lib, userName, ... }:

let
  inherit (lib) mkOption mkIf;
  cfg = config.myDocker;
  inherit userName;
in {
  options.myDocker = {

    enable = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Configure Docker and Docker-Compose" ;
    };
  };

  config = mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;   
      enableNvidia = config.myNvidia.enable;
    };

    users.users.${userName}.extraGroups = [ "docker" ];
    virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };
    environment.systemPackages = with pkgs; [
      docker-compose
    ]; 
  };
}

