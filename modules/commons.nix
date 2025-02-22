{
  config,
  pkgs,
  lib,
  userName,
  ...
}:
let
  inherit (lib) mkOption mkIf;
  cfg = config.myCommons;
  inherit userName;
in
{
  options.myCommons = {
    enable = mkOption {
      type = lib.types.bool;
      default = true;
      example = false;
      description = "Common functionalities of all possible configs. Enabled by default.";
    };
  };

  config = mkIf cfg.enable {
    programs.ssh = {
      startAgent = true;
    };

    programs.firefox = mkIf (config.myUi.useGUI) {
      enable = true;
    };

    programs.starship = {
      enable = true;
    };

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
    };
    programs.fish.enable = true;

    users.users.${userName}.shell = pkgs.fish;

    services.syncthing.enable = config.myUi.useGUI;

    programs.git = {
      enable = true;
    };

    # Source: https://nixos.wiki/wiki/Fish
    programs.bash = {
      interactiveShellInit = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
    };

    fonts.fontconfig.enable = true;

    fonts.packages =
      with pkgs;
      [
        noto-fonts
        noto-fonts-emoji
        victor-mono
        fira-code
        fira-code-symbols
      ]
      ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts); # This little trick add every nerd-font

    environment.systemPackages =
      with pkgs;
      [
        zoxide
        wget
        curl
        xbindkeys
        pinentry-all
        alacritty
        kitty
        rsync
        xclip
        unzip
        man-pages
        man-pages-posix
        zip
        nil
        nixfmt-rfc-style
      ]
      ++ pkgs.lib.optionals (config.myUi.useGUI) [
        discord
        feh
        zathura
        newsboat
        obsidian
      ];
  };
}
