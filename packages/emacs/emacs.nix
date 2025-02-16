{ config, pkgs, lib, ... }:
let
  inherit (lib) mkOption mkIf;
  inherit (pkgs.lib)  optionals;
  cfg = config.myDevTools;
in {
  options.MyNeovim = {
    enable = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Configure neovim for development";
    };
  };

  options.myNeovimMainEditor = {
    enable = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Configure neovim to be the main editor";
    };
  };

  config = mkIf cfg.enable {
    programs.neovim = {
        enable = true;
        defaultEditor = true;

  viAlias = true;
  vimAlias = true;
    };
    environment.systemPackages = with pkgs; [
      # Emacs
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
      # jansson # library for json in emacs<30
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
      zellij
      # (pkgs.callPackage ../packages/json5/json5.nix {})
      vimPlugins.nvim-treesitter
    tree-sitter
      tldr
      gccgo14
    ]
    ++ optionals (config.myDocker.enable) [lazydocker];
  };
}
