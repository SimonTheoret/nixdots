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
          "*/15 * * * * ${userName}  $HOME/bin/sync.sh | tee $HOME/.sync.log"
        ];
    };
  };
}
