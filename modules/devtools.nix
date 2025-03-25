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
  };

  config = mkIf cfg.enable {
    programs.direnv = {
      silent = false;
      loadInNixShell = true;
      enableFishIntegration = true;
      nix-direnv.enable = true;
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
        htop
        zellij
        tmux
        tldr
        nodePackages.prettier
        bash-language-server
        shellharden
        shfmt
        sqruff
        calc
        delta
      ]
      ++ [ pkgsUnstable.lazygit ]
      ++ optionals (config.myDocker.enable) [ lazydocker ];
  };
}
