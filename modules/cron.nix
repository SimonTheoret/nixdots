{
  config,
  lib,
  userName,
  ...
}:
let
  inherit (lib) optionals;
  inherit (lib) mkOption mkIf;
  cfg = config.myCron;
in
{
  options.myCron = {
    enable = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Configure cronjobs";
    };
  };

  config = mkIf cfg.enable {
    services.cron = {
      enable = true;
      systemCronJobs =
        [ ]
        ++ optionals (config.mySync.enable) [
          "*/15 * * * * ${userName}  . $HOME/.aws_env; $HOME/bin/sync.sh | tee $HOME/.sync.log"
        ]
        ++ optionals (config.myCleanup.enable) [
          "* 17 * * 5 root  nix-store --verify --check-contents --repair"
        ];
    };
  };
}
