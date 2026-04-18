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
      description = "Enable integration with Ollama, AIChat and Claude Code";
    };

    kbConfigSoftware = mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Enable Bazecore for configuring a dygma keyboard";
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
        "qwen3:4b"
        "qwen2.5-coder:7b"
        "qwen2.5-coder:32b"
        "devstral:24b"
      ];
      package = if config.myNvidia.enable then pkgs.ollama-cuda else pkgs.ollama;
      acceleration = if config.myNvidia.enable then "cuda" else false;
    };

    services.pcscd.enable = true;
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = false;
    };
    programs.fzf = {
      keybindings = true;
      fuzzyCompletion = true;
    };

    environment.systemPackages = [
      pkgsUnstable.eza
      pkgsUnstable.gnumake
      pkgsUnstable.zathura
      pkgsUnstable.direnv
      pkgsUnstable.fd
      pkgsUnstable.fzf
      pkgsUnstable.bat
      pkgsUnstable.ripgrep
      pkgsUnstable.btop
      pkgsUnstable.htop
      pkgsUnstable.tmux
      pkgsUnstable.tldr
      pkgsUnstable.prettier
      pkgsUnstable.bash-language-server
      pkgsUnstable.shellharden
      pkgsUnstable.shfmt
      pkgsUnstable.calc
      pkgsUnstable.delta
      pkgsUnstable.yazi
      pkgsUnstable.nodejs_24
      pkgsUnstable.python314
      pkgsUnstable.scooter
      pkgsUnstable.dust
    ]
    ++ [
      pkgsUnstable.lazygit
      pkgsUnstable.gitui
      pkgsUnstable.zellij
    ]
    ++ optionals (config.myDocker.enable) [ pkgs.lazydocker ]
    ++ optionals (config.myUi.useGUI && !config.myUi.hyprland) [ pkgs.drawio ]
    ++ optionals (config.myDevTools.useLLM) [
      pkgs.aichat
    ]
    ++ optionals (config.myDevTools.useLLM) [
      pkgs.bazecor
    ]
    ++ optionals (config.myDevTools.useLLM) [
      pkgsUnstable.claude-code
    ];
  };
}
