{ config, pkgs, lib, ... }:
let
  inherit (lib) mkOption mkIf;
  cfg = config.myHomeManager;
in {
  options.myHomeManager = {
    enable = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Use Home-Manager to configure emails with msmtp and mbsync" ;
    };
  };

  config = mkIf cfg.enable {
    home.stateVersion = "24.11";
    programs.home-manager.enable = true;

    programs.mbsync.enable = true;
    programs.msmtp.enable = true;

    accounts.email = {
      accounts.hotmail = {
        address = "simonteoret@hotmail.com";
        primary = true;
        flavor = "outlook.office365.com"; # this makes it easy
        mbsync = {
          enable = true;
          create = "maildir";
          expunge = "both";
        };
        msmtp.enable = true;
        realName = "Simon Théorêt";
        passwordCommand = "gpg2 -q --for-your-eyes-only --no-tty -d ~/.mymail.gpg";
        userName = "simonteoret@hotmail.com";
      };
    };
  };
}
