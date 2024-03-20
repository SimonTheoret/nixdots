{ config, pkgs, ... }: {
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
    firefox
    nodePackages_latest.npm
    bat
    yarn
    ripgrep
    btop
    discord
    feh
    thunderbird
    tldr
    playerctl
    maim
    trashy
    pandoc
    obsidian
    sshfs
    nerdfonts
    fd

    # Python
    python3Full
    virtualenv
    nodePackages_latest.pyright
    ruff-lsp
    isort
    ruff

    # Rust
    rustc
    cargo
    rustfmt
    pkg-config
    cargo-deny
    cargo-edit
    cargo-watch
    rust-analyzer

    # LaTeX
    texlive.combined.scheme-full

    # Emacs
    emacs29
    emacs-all-the-icons-fonts
    # emacsPackages.all-the-icons-nerd-fonts
    emacsPackages.vterm
    emacsPackages.pdf-tools
    # isync
    # msmtp
    # notmuch

    # Nix
    nil
    nixfmt

    # Lua
    lua
    lua-language-server

    # Go
    go
    gotools # goimports, godoc, etc.
    golangci-lint # https://github.com/golangci/golangci-lint
    gofumpt

    # bash
    nodePackages_latest.bash-language-server
    shfmt
    shellcheck

    # Markdown
    marksman

    # needed, at least until direnv !
    # pkgs.redshift
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

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
      credential.helper = "${
          pkgs.git.override { withLibsecret = true; }
        }/bin/git-credential-libsecret";
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

  programs.kitty = {
    enable = true;
    settings = {
      font_family = "FiraCode Nerd Font Mono";
      bold_font = "FiraCode Nerd Font Mono Bold";
      italic_font = "VictorMono NFM SemiBold Italic";
      bold_italic_font = "VictorMono NFM Bold Italic";
      font_size = 9;
      background_opacity = "0.80";
      background_blur = 32;
    };
    keybindings = {
      "kitty_mod+k" = "scroll_line_up";
      "kitty_mod+j" = "scroll_line_down";
      "kitty_mod+u" = "scroll_page_up";
      "kitty_mod+d" = "scroll_page_down";
      "kitty_mod+enter" = "launch --cwd=current";
      "alt+w" = "close_window";
      "alt+k" = "next_window";
      "alt+j" = "previous_window";
      "alt+l" = "next_tab";
      "alt+h" = "previous_tab";
      "alt+t" = "new_tab_with_cwd";
      "alt+q" = "close_tab";
      "alt+r+t" = "set_tab_title";
      "kitty_mod+1" = "goto_tab 1";
      "kitty_mod+2" = "goto_tab 2";
      "kitty_mod+3" = "goto_tab 3";
      "kitty_mod+4" = "goto_tab 4";
      "kitty_mod+5" = "goto_tab 5";
      "kitty_mod+6" = "goto_tab 6";
      "kitty_mod+7" = "goto_tab 7";
      "kitty_mod+8" = "goto_tab 8";
      "kitty_mod+9" = "goto_tab 9";
    };
    shellIntegration.enableZshIntegration = true;
    theme = "Molokai";
  };

  programs.zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";
      sandbox = "none";
      synctex = "true";
      notification-error-bg = "#f7768e";
      notification-error-fg = "#c0caf5";
      notification-warning-bg = "#e0af68";
      notification-warning-fg = "#414868";
      notification-bg = "#1a1b26";
      notification-fg = "#c0caf5";
      completion-bg = "#1a1b26";
      completion-fg = "#a9b1d6";
      completion-group-bg = "#1a1b26";
      completion-group-fg = "#a9b1d6";
      completion-highlight-bg = "#414868";
      completion-highlight-fg = "#c0caf5";
      index-bg = "#1a1b26";
      index-fg = "#c0caf5";
      index-active-bg = "#414868";
      index-active-fg = "#c0caf5";
      inputbar-bg = "#1a1b26";
      inputbar-fg = "#c0caf5";
      statusbar-bg = "#1a1b26";
      statusbar-fg = "#c0caf5";
      highlight-color = "#e0af68";
      highlight-active-color = "#9ece6a";
      default-bg = "#1a1b26";
      default-fg = "#c0caf5";
      render-loading = "true";
      render-loading-fg = "#1a1b26";
      render-loading-bg = "#c0caf5";
      recolor-lightcolor = "#1a1b26";
      recolor-darkcolor = "#c0caf5";
    };
    extraConfig = ''
      #tokyonight color scheme
      set recolor
      set recolor-keephue
    '';
  };

  services.ssh-agent.enable = true;
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    extraConfig = ''
      Match all
              ServerAliveInterval 60
              ServerAliveCountMax 5'';
  };

  #Starship
  programs.starship = {
    enable = true;
    settings = {
      aws = { symbol = "  "; };
      buf = { symbol = " "; };
      c = { symbol = " "; };
      conda = { symbol = " "; };
      crystal = { symbol = " "; };
      dart = { symbol = " "; };
      directory = { read_only = " 󰌾"; };
      docker_context = { symbol = " "; };
      elixir = { symbol = " "; };
      elm = { symbol = " "; };
      fennel = { symbol = " "; };
      fossil_branch = { symbol = " "; };
      git_branch = { symbol = " "; };
      golang = { symbol = " "; };
      guix_shell = { symbol = " "; };
      haskell = { symbol = " "; };
      haxe = { symbol = " "; };
      hg_branch = { symbol = " "; };
      hostname = { ssh_symbol = " "; };
      java = { symbol = " "; };
      julia = { symbol = " "; };
      kotlin = { symbol = " "; };
      lua = { symbol = " "; };
      memory_usage = { symbol = "󰍛 "; };
      meson = { symbol = "󰔷 "; };
      nim = { symbol = "󰆥 "; };
      nix_shell = { symbol = " "; };
      nodejs = { symbol = " "; };
      ocaml = { symbol = " "; };
      os.disabled = false;
      os.symbols = {
        Alpaquita = " ";
        Alpine = " ";
        Amazon = " ";
        Android = " ";
        Arch = " ";
        Artix = " ";
        CentOS = " ";
        Debian = " ";
        DragonFly = " ";
        Emscripten = " ";
        EndeavourOS = " ";
        Fedora = " ";
        FreeBSD = " ";
        Garuda = "󰛓 ";
        Gentoo = " ";
        HardenedBSD = "󰞌 ";
        Illumos = "󰈸 ";
        Linux = " ";
        Mabox = " ";
        Macos = " ";
        Manjaro = " ";
        Mariner = " ";
        MidnightBSD = " ";
        Mint = " ";
        NetBSD = " ";
        NixOS = " ";
        OpenBSD = "󰈺 ";
        openSUSE = " ";
        OracleLinux = "󰌷 ";
        Pop = " ";
        Raspbian = " ";
        Redhat = " ";
        RedHatEnterprise = " ";
        Redox = "󰀘 ";
        Solus = "󰠳 ";
        SUSE = " ";
        Ubuntu = " ";
        Unknown = " ";
        Windows = "󰍲 ";
      };

      package = { symbol = "󰏗 "; };
      perl = { symbol = " "; };
      php = { symbol = " "; };
      pijul_channel = { symbol = " "; };
      python = { symbol = " "; };
      rlang = { symbol = "󰟔 "; };
      ruby = { symbol = " "; };
      rust = { symbol = " "; };
      scala = { symbol = " "; };
      swift = { symbol = " "; };
      zig = { symbol = " "; };
    };
  };

  #Neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  #Zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting = { enable = true; };
    shellAliases = {
      cd = "z";
      gitg =
        "git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all";
      gita = "git add";
      gitc = "git commit -m";
      gits = "git status";
      gitp = "git push";
      update = "sudo nixos-rebuild switch --flake ";
      # sec = "$EDITOR $HOME/dotfiles/nix/nixos/configuration.nix";
      # hupdates =
      #   "home-manager switch --flake $HOME/dotfiles/home-manager/#simon";
      # hme =
      #   "$EDITOR ${config.home.homeDirectory}/.config/home-manager/homenix/home.nix";
      rm = "trash";
    };
  };

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
    EDITOR = "nvim";
    BROWSER = "firefox";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.config = { allowUnfree = true; };
}
