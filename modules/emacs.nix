{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) mkOption mkIf;
  cfg = config.myDevTools;
in
{
  options.myEmacs = {
    enable = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Configure Emacs for development";
    };

    mainEditor = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Configure Emacs to be the main editor";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      emacs30
      emacs-lsp-booster
      emacsPackages.vterm
      emacsPackages.pdf-tools
      emacs-all-the-icons-fonts
      mu
      ispell
      aspell
      aspellDicts.fr
      aspellDicts.en
    ];
  };
}
