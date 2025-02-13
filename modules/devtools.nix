{ config, pkgs, lib, ... }:
let
  inherit (lib) mkOption mkIf;
  inherit (pkgs.lib)  optionals;
  cfg = config.myDevTools;
in {
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
      direnvrcExtra = "";
      nix-direnv = {
        enable = true;
        package = pkgs.nix-direnv;
      };
      environment.systemPackages = with pkgs; [
        emacs
        eza
        zathura
        direnv
        fd
        fzf
        bat
        yarn
        ripgrep
        btop
        ispell
        jansson # library for json (emacs lsp)
        librsvg # for viewing svg images
        sqlite
        mu
        meson # Needed to build mu4e in emacs
        aspell
        aspellDicts.fr
        aspellDicts.en
        zellij
        neovim
      ]
      ++ optionals (config.myDocker.enable) [lazydocker];
    };
  };
}
