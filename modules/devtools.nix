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

    services.lorri.enable = false;

    services.pcscd.enable = true;
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = false;
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
        yazi
        nodejs_23
        mcfly
        python3Full
        gnupg
        pinentry-all
      ]
      ++ [ pkgsUnstable.lazygit ]
      ++ optionals (config.myDocker.enable) [ lazydocker ];
  };
}
