{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) mkOption mkIf;
  cfg = config.myEmacs;
in
{
  options.myEmacs = {
    enable = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Configure Emacs for development";
    };
    pgtk = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Configure Emacs for development on Wayland";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages =
      pkgs.lib.optionals (cfg.enable) [
        pkgs.emacs-lsp-booster
        pkgs.libtool # Needed to compile vterm
        pkgs.emacs-all-the-icons-fonts
        pkgs.mu
        pkgs.ispell
        pkgs.aspell
        pkgs.aspellDicts.fr
        pkgs.aspellDicts.en
      ]
      ++ pkgs.lib.optionals (!cfg.pgtk && cfg.enable) [
        pkgs.emacs
      ]
      ++ pkgs.lib.optionals (cfg.pgtk && cfg.enable) [
        pkgs.emacs-pgtk
      ];
  };
}
