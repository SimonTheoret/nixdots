{ config, pkgs, lib, userName, ... }:
let
  inherit (lib) mkOption mkIf;
  cfg = config.myCommons;
  inherit userName;
in {
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
    };

    users.users.${userName}.shell = pkgs.zsh;


    services.syncthing.enable = mkIf (config.myUi.useGUI);

    programs.git = {
      enable = true;
    };

    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      settings = {
        default-cache-ttl = 36000; # 10 hours
      };
    };

    fonts.fontconfig.enable = true;
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-emoji
      victor-mono
      fira-code
      fira-code-symbols
    ];

    environment.systemPackages = with pkgs; [
      wget
      curl
      pinentry
      nerdfonts
      alacritty
      zimfw
      rsync
      xclip
      unzip
      man-pages
      man-pages-posix
      zip
      zoxide
    ] ++ pkgs.lib.optionals (config.myUi.useGUI) [ discord feh zathura];
  };
}

