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
    useLLM = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Enable integration with Ollama, AIChat, Aider and Claude Code";
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

    services.ollama = {
      enable = cfg.useLLM;
      loadModels = [
        "qwen2.5-coder:7b"
        "qwen2.5-coder:32b"
        "devstral:24b"
      ];
      package = if config.myNvidia.enable then pkgs.ollama-cuda else pkgs.ollama;
    };

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
        nodejs_24
        mcfly
        python3Full
        pinentry-all
        rs-git-fsmonitor
        scooter
        mosh
        commitizen
        pre-commit
        dust
      ]
      ++ [
        pkgsUnstable.lazygit
        pkgsUnstable.zellij
      ]
      ++ optionals (config.myDocker.enable) [ lazydocker ]
      ++ optionals (config.myUi.useGUI && !config.myUi.hyprland) [ drawio ]
      ++ optionals (config.myDevTools.useLLM) [
        aichat
        claude-code
        aider-chat-full
      ];
  };
}
