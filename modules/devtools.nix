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

    environment.systemPackages = [
      pkgs.eza
      pkgs.gnumake
      pkgs.zathura
      pkgs.direnv
      pkgs.fd
      pkgs.fzf
      pkgs.bat
      pkgs.ripgrep
      pkgs.btop
      pkgs.htop
      pkgs.tmux
      pkgs.tldr
      pkgs.nodePackages.prettier
      pkgs.bash-language-server
      pkgs.shellharden
      pkgs.shfmt
      pkgs.sqruff
      pkgs.calc
      pkgs.delta
      pkgs.yazi
      pkgs.nodejs_24
      pkgs.mcfly
      pkgs.python3Full
      pkgs.pinentry-all
      pkgs.rs-git-fsmonitor
      pkgs.scooter
      pkgs.mosh
      pkgs.commitizen
      pkgs.pre-commit
      pkgs.dust
    ]
    ++ [
      pkgsUnstable.lazygit
      pkgsUnstable.zellij
    ]
    ++ optionals (config.myDocker.enable) [ pkgs.lazydocker ]
    ++ optionals (config.myUi.useGUI && !config.myUi.hyprland) [ pkgs.drawio ]
    ++ optionals (config.myDevTools.useLLM) [
      pkgs.aichat
      pkgs.aider-chat-full
    ]
    ++ optionals (config.myDevTools.useLLM) [
      pkgsUnstable.claude-code
    ];
  };
}
