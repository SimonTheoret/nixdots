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
    services.xserver.enable = true;
    services.displayManager.defaultSession = "none+i3";
    services.xserver.windowManager.i3.enable = true;
    services.xserver.desktopManager.xterm.enable = true;

    environment.systemPackages = with pkgs; [
      i3status-rust
      i3lock
    ]
    ++ pkgs.lib.optionals (cfg.monitorsConfig) [(pkgs.callPackage ../packages/autorandr/autorandr.nix {})]
    ++ pkgs.lib.optionals (cfg.useGUI) [picom maim dunst flashfocus autotiling];
  };
}

