{
  config,
  lib,
  pkgsUnstable,
  ...
}:
let
  inherit (lib) mkOption mkIf;
  cfg = config.myNeovim;
in
{
  options.myNeovim = {
    enable = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Configure Neovim for development";
    };
  };

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      package = pkgsUnstable.neovim-unwrapped;
    };

    environment.systemPackages = with pkgsUnstable; [
      cmake # Needed to build some plugins
      cargo # Needed to build nvim Lua-Json5 plugin
      tree-sitter
      nodejs_24
      glib
      gcc
      lua-language-server
      pandoc # For feed.nvim
      lua-language-server
    ];
  };
}
