{ config, pkgs, laptop ? false, ... }: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "simon";
  home.homeDirectory = "/home/simon";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.

  home.packages = with pkgs; [
    nodePackages_latest.npm
    bat
    yarn
    ripgrep
    btop
    discord
    # thunderbird
    tldr
    playerctl
    maim
    trash-cli
    pandoc
    sshfs
    nerdfonts
    fd
    feh
    (pkgs.callPackage ../packages/timer/timer.nix { })

    # Python
    # python3Full
    # virtualenv
    # nodePackages_latest.pyright
    # ruff-lsp
    # isort
    # ruff

    # Rust
    # rustc
    # cargo
    # rustfmt
    # pkg-config
    # cargo-deny
    # cargo-edit
    # cargo-watch
    # rust-analyzer

    # LaTeX
    # texlive.combined.scheme-full

    # Emacs
    emacs-gtk
    emacs-all-the-icons-fonts
    # emacsPackages.all-the-icons-nerd-fonts
    emacsPackages.vterm
    emacsPackages.pdf-tools
    emacsPackages.mu4e
    ispell
    jansson # library for json (emacs lsp)
    librsvg # for viewing svg images
    sqlite
    isync
    msmtp
    mu
    meson # Needed to build mu4e in emacs
    aspell
    aspellDicts.fr
    aspellDicts.en

    feh
    nomacs
    (pkgs.callPackage ../scripts/calc.nix { inherit pkgs; })

    gnupg
    pinentry

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  home.sessionVariables = { WEBKIT_DISABLE_COMPOSITING_MODE = 1; };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true; # see note on other shells below
    nix-direnv.enable = true;
  };

  services.syncthing.enable = true;

  programs.git = {
    enable = true;
    userName = "Simon Théorêt";
    userEmail = "simonteoret@hotmail.com";
    extraConfig = {
      init = { defaultBranch = "main"; };
      diff = {
        tool = "kitty";
        guitool = "kitty.gui";
      };
    };
  };

  programs.eza = {
    enable = true;
    icons = true;
    git = true;
    enableZshIntegration = true;
  };

  programs.kitty = import ../packages/kitty/kitty.nix
    (pkgs.lib.optionalAttrs (laptop) { fontsize = 11; });

  programs.zathura = import ../packages/zathura/zathura.nix;

  services.ssh-agent.enable = true;
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    extraConfig = ''
      Match all
              ServerAliveInterval 60
              ServerAliveCountMax 5'';
  };

  programs.firefox = {
    enable = true;
    profiles.default = {
      name = "default";
      isDefault = true;
    };
  };

  programs.mbsync = {
    enable = true;
    # extraConfig = "Remove Both";
  };
  programs.msmtp.enable = true;

  accounts.email = (import ../packages/emails/accounts.nix);

  #Starship
  programs.starship = {
    enable = true;
    settings = import ../packages/starship/starship.nix;
  };

  #Neovim
  programs.neovim = { enable = true; };

  #Zsh
  programs.zsh = import ../packages/zsh/zsh.nix;

  #Zoxide
  programs.zoxide = { enable = true; };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    "./.config/nvim/" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dotfiles/packages/nvim";
      recursive = true;
    };
    "${config.home.homeDirectory}/.config/emacs/conf" = {
      # source = ../packages/emacs/conf;
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dotfiles/packages/emacs/conf";
      recursive = true;
    };

    "${config.home.homeDirectory}/.config/emacs/init.el" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dotfiles/packages/emacs/init.el";
      recursive = false;
    };

    "${config.home.homeDirectory}/.config/emacs/doom-molokai-sick-theme.el".source =
      config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/packages/emacs/doom-molokai-sick-theme.el";

    "${config.home.homeDirectory}/.config/emacs/early-init.el".source =
      config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/packages/emacs/early-init.el";

    "${config.home.homeDirectory}/.config/emacs/packages.el".source =
      config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/packages/emacs/packages.el";

    "${config.home.homeDirectory}/.config/emacs/true.png".source =
      config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/packages/emacs/true.png";
    "${config.home.homeDirectory}/.config/pypoetry/config.toml" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dotfiles/packages/poetry/config.toml";
    };
    "${config.home.homeDirectory}/Images/nixart/" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dotfiles/nixart";
      recursive = true;
    };
    "${config.home.homeDirectory}/.aspell.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dotfiles/packages/aspell/aspell.conf";
    };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/simon/etc/profile.d/hm-session-vars.sh
  #

  home.sessionVariables = {
    EDITOR = "emacsclient";
    BROWSER = "firefox";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.config = { allowUnfree = true; };
}
