{
  config,
  pkgs,
  lib,
  pkgsUnstable,
  ...
}:
let
  inherit (lib) mkOption mkIf;
  inherit (pkgs.lib) optionals;
  cfg = config.myDevTools;
in
{
  options.myDevTools = {

    enable = mkOption {
      type = lib.types.bool;
      default = true;
      example = false;
      description = "Packages used to create a development environment";
    };

    kbConfigSoftware = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Enable Bazecore for configuring a dygma keyboard";
    };
    drawingTools = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Enable Draw.io and Drawy";
    };

  };

  config = mkIf cfg.enable {
    programs.direnv = {
      silent = false;
      loadInNixShell = true;
      enableFishIntegration = true;
      nix-direnv.enable = true;
    };

    services.lorri.enable = false;

    services.pcscd.enable = true;
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = false;
    };
    programs.fzf = {
      keybindings = true;
      fuzzyCompletion = true;
    };

    environment.systemPackages = [
      pkgs.eza
      pkgs.gnumake
      pkgs.direnv
      pkgs.fd
      pkgs.fzf
      pkgs.bat
      pkgs.ripgrep
      pkgs.btop
      pkgs.tldr
      pkgs.bash-language-server
      pkgs.shellcheck
      pkgs.shfmt
      pkgs.delta
      pkgs.yazi
      pkgs.python314
      pkgs.nix-fast-build
      pkgs.charles
      pkgs.gh
      pkgs.scooter
      pkgs.codex
      (pkgs.callPackage ../packages/tuicr/default.nix { })
    ]
    ++ [
      pkgsUnstable.lazygit
      pkgsUnstable.zellij
      pkgsUnstable.claude-code
    ]
    ++ optionals (config.myVirtualisation.enable) [ pkgs.lazydocker ]
    ++ optionals (config.myUi.useGUI && cfg.drawingTools) [
      pkgs.drawio
      pkgs.drawy
    ]
    ++ optionals (config.myDevTools.kbConfigSoftware) [
      pkgs.bazecor
    ];
  };
}
