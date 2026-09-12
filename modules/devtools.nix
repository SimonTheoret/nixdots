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
      pkgsUnstable.eza
      pkgsUnstable.gnumake
      pkgsUnstable.direnv
      pkgsUnstable.fd
      pkgsUnstable.fzf
      pkgsUnstable.bat
      pkgsUnstable.ripgrep
      pkgsUnstable.btop
      pkgsUnstable.tldr
      pkgsUnstable.prettier
      pkgsUnstable.bash-language-server
      pkgsUnstable.shellharden
      pkgsUnstable.shellcheck
      pkgsUnstable.shfmt
      pkgsUnstable.delta
      pkgsUnstable.yazi
      pkgsUnstable.python314
      pkgsUnstable.scooter
      pkgsUnstable.dust
      pkgsUnstable.yaml-language-server
      pkgsUnstable.docker-language-server
      pkgsUnstable.systemctl-tui
      pkgsUnstable.nix-fast-build
      pkgsUnstable.charles
      pkgsUnstable.opencode
      pkgsUnstable.tuicr
    ]
    ++ [
      pkgsUnstable.lazygit
      pkgsUnstable.gitui
      pkgsUnstable.zellij
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
