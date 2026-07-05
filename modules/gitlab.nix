{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkOption mkIf;
  cfg = config.myGitlab;
in
{
  options.myGitlab = {
    enable = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Use local Gitlab.";
    };
  };

  config = mkIf cfg.enable {
    services.gitlab = {
      enable = true;
      databasePasswordFile = pkgs.writeText "dbPassword" "zgvcyfwsxzcwr85l";
      initialRootPasswordFile = pkgs.writeText "rootPassword" "dakqdvp4ovhksxer";
      secrets = {
        secretFile = pkgs.writeText "secret" "Aig5zaic";
        otpFile = pkgs.writeText "otpsecret" "Riew9mue";
        dbFile = pkgs.writeText "dbsecret" "we2quaeZ";
        jwsFile = pkgs.runCommand "oidcKeyBase" { } "${pkgs.openssl}/bin/openssl genrsa 2048 > $out";
        activeRecordPrimaryKeyFile = "/var/lib/gitlab/secrets/activeRecordPrimaryKey";
        activeRecordDeterministicKeyFile = "/var/lib/gitlab/secrets/activeRecordDeterministicKey";
        activeRecordSaltFile = "/var/lib/gitlab/secrets/activeRecordSalt";
      };
    };

    services.nginx = {
      enable = true;
      recommendedProxySettings = true;
      virtualHosts = {
        localhost = {
          locations."/".proxyPass = "http://unix:/run/gitlab/gitlab-workhorse.socket";
        };
      };
    };

    # services.openssh.enable = true;

    systemd.services.gitlab-backup.environment.BACKUP = "dump";
  };
}
