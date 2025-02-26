{
  config,
  pkgs,
  lib,
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
  };

  config = mkIf cfg.enable {
    programs.direnv = {
      package = pkgs.direnv;
      silent = false;
      loadInNixShell = true;
      enableFishIntegration = true;
      direnvrcExtra = "";
      nix-direnv = {
        enable = true;
        package = pkgs.nix-direnv;
      };
    };
    environment.systemPackages =
      with pkgs;
      [
        eza
        gnumake
        zathura
        direnv
        fd
        fzf
        bat
        ripgrep
        btop
        zellij
        tldr
      ]
      ++ optionals (config.myDocker.enable) [ lazydocker ];
  };
}
