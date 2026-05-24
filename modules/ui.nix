{
  config,
  pkgs,
  lib,
  userName,
  ...
}:

let
  inherit (lib) mkOption mkIf;
  cfg = config.myUi;
in
{
  options.myUi = {
    enable = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Configure the UI. Can activate i3WM, monitor configuration and specify if in a GUI environment";
    };
    i3WM = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Configure i3WM";
    };
    hyprland = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Configure HyprlandWM";
    };
    niri = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Configure Niri";
    };
    cosmic = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Configure Cosmic";
    };

    monitorsConfig = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Use Autorandr to configure specific monitors.";
    };
    useGUI = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Does the current system supports a GUI";
    };
  };

  config = mkIf cfg.enable {
    services.xserver.enable = cfg.i3WM || cfg.hyprland;

    services.displayManager.cosmic-greeter.enable = cfg.cosmic;
    services.desktopManager.cosmic.enable = cfg.cosmic;

    services.desktopManager.cosmic.xwayland.enable = cfg.cosmic;
    services.displayManager.defaultSession =
      if cfg.i3WM then
        "none+i3"
      else if cfg.hyprland then
        "hyprland"
      else
        abort "Unsupported default session for displayManager";
    services.displayManager.sddm = mkIf cfg.hyprland {
      enable = true;
      wayland.enable = true;
    };

    programs.niri.enable = cfg.niri;

    services.greetd = mkIf cfg.niri {
      enable = true;
      settings = {
        default_session = {
          command = "${config.programs.niri.package}/bin/niri-session";
          user = "${userName}";
        };
      };
    };

    # NixOS otherwise injects a stripped PATH via Environment= on the niri.service
    # unit which shadows the imported user-manager PATH. Disabling the default
    # lets niri inherit the full PATH set up by niri-session.
    systemd.user.services.niri.enableDefaultPath = false;

    services.gnome.gnome-keyring.enable = cfg.niri || cfg.hyprland; # secret service
    security.pam.services.swaylock = mkIf (cfg.niri || cfg.hyprland) { };

    programs.hyprland = mkIf cfg.hyprland {
      enable = true;
      xwayland.enable = true;
    };

    xdg.portal = mkIf cfg.hyprland { enable = true; };
    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = lib.optionals cfg.hyprland "1";
      NIXOS_OZONE_WL = lib.optionals cfg.hyprland "1";
      ELECTRON_OZONE_PLATFORM_HINT = lib.optionals cfg.hyprland "1";
    };
    environment.systemPackages =
      with pkgs;
      [ ]
      ++ pkgs.lib.optionals (cfg.hyprland) [ xdg-desktop-portal-gtk ]
      ++ pkgs.lib.optionals (cfg.monitorsConfig && cfg.i3WM) [
        (pkgs.callPackage ../packages/autorandr/autorandr.nix { })
      ]
      ++ pkgs.lib.optionals (cfg.monitorsConfig && cfg.hyprland) [ ]
      ++ pkgs.lib.optionals (cfg.hyprland) [
        waybar
        hyprpaper
        hyprshot
        swaylock
        swayidle
      ]
      ++ pkgs.lib.optionals (cfg.niri) [
        waybar
        fuzzel
        swaylock
        mako
        swayidle
      ]
      ++ pkgs.lib.optionals (cfg.i3WM) [
        i3status-rust
        i3lock
        picom
        maim
        dunst
        flashfocus
        autotiling
      ]
      ++ pkgs.lib.optionals (cfg.useGUI) [
        dunst
        wl-clipboard
        wofi
      ];
  };
}
