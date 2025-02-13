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
    };
    environment.systemPackages = with pkgs; [
      # Emacs
      emacs
      emacs-lsp-booster
      emacsPackages.vterm
      emacsPackages.pdf-tools
      emacsPackages.mu4e
      emacs-all-the-icons-fonts
      mu
      ispell
      aspell
      aspellDicts.fr
      aspellDicts.en
      jansson # library for json (emacs lsp)
      # misc
      eza
      gnumake
      cmake
      zathura
      direnv
      fd
      fzf
      bat
      yarn
      ripgrep
      btop
      librsvg # for viewing svg images
      sqlite
      meson # Needed to build mu4e in emacs
      zellij
      neovim
    ]
    ++ optionals (config.myDocker.enable) [lazydocker];
  };
}
