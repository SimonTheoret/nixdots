{ config, pkgs, lib, ... }:

let
  inherit (lib) mkOption mkIf;
  cfg = config.myUi;
in {
  options.myUi = {
    enable = mkOption {
      type = lib.types.bool;
      default = false;
      example = true; description = "Configure the UI. Can activate i3WM, monitor configuration and specify if in a GUI environment" ;
    };
    monitorsConfig = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Use Autorandr to configure specific monitors.";
    };
    useGUI = mkOption{
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Does the current system supports a GUI";
    };
  };

  config = mkIf cfg.enable {
    services.xserver.windowManager.i3.enable = true;
    services.xserver.desktopManager.xterm.enable = true;

    services.picom = {
      enable = cfg.useGUI;
      vSync = true;
      backend = "xrender";
      settings = { unredir-if-possible = false; };
    };

    services.dunst = { enable = cfg.useGUI; };

    environment.systemPackages = with pkgs; [
      i3status-rust
    ]
    ++ pkgs.lib.optionals (cfg.monitorsConfig) [autorandr]
    ++ pkgs.lib.optionals (cfg.useGUI) [maim dunst];
  };
}

