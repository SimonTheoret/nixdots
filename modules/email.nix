{
  config,
  pkgs,
  lib,
  ...
}:

let
  inherit (lib) mkOption mkIf;
  cfg = config.myEmail;
in
{
  options.myEmail = {
    enable = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Setup email applications";
    };
    gui = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Setup email GUI applications";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages =
      with pkgs;
      [
        isync
        msmtp
        gnupg
        neomutt
        notmuch
        lynx
      ]
      ++ pkgs.lib.optionals (config.myUi.useGUI || cfg.gui) [ thunderbird ];
  };
}
