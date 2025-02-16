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
  options.myNeovim = {
    enable = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Configure Neovim for development";
    };

    mainEditor = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Configure Neovim to be the main editor";
    };
  };

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true && cfg.enable;
      viAlias = true;
      vimAlias = true;
    };

    environment.systemPackages = with pkgs; [
      cmake # Needed to build some plugins
      # (pkgs.callPackage ../packages/json5/json5.nix {}) # Needed for json5 parsing in DAP
      tree-sitter
      nodejs_23
      gccgo14
      lua-language-server
    ];
  };
}
