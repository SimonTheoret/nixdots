{ config, lib, pkgs, ... }:

{
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
    flashfocus
    nodePackages_latest.npm
    bat
    autotiling
    yarn
    ripgrep
    nixfmt
    lua-language-server
    btop
    discord
    feh
    thunderbird
    tldr
    playerctl
    maim
    trashy
    nil
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

  programs.git = {
    enable = true;
    userName = "Simon Théorêt";
    userEmail = "simonteoret@hotmail.com";
    extraConfig = {
          credential.helper = "${
              pkgs.git.override { withLibsecret = true; }
            }/bin/git-credential-libsecret";
          init = {
            defaultBranch = "main";
          };
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
    enableAliases = true;
  };

  programs.kitty = {
    enable = true;
    settings = {
      font_family = "FiraCode Nerd Font Mono";
      bold_font = "FiraCode Nerd Font Mono Bold";
      italic_font = "VictorMono NFM SemiBold Italic";
      bold_italic_font = "VictorMono NFM Bold Italic";
      font_size = 9;
      background_opacity = 1;
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
    theme = "Tokyo Night";
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

  programs.autorandr = {
    enable = true;
    profiles = {
      "3screens" = {
        fingerprint = {
          DP-0 =
            "00ffffffffffff0006b3af2701010101211e0104a53c22783b07f0a655539e270e5054b7ef00714f8180814081c081009500b3000101023a801871382d40582c450056502100001e000000fd002890a0a021010a202020202020000000fc0056473237380a20202020202020000000ff004c384c4d51533037343732320a01eb020318f14b900504030201111213141f2309070783010000023a801871382d40582c450056502100001e8a4d80a070382c403020350056502100001afe5b80a0703835403020350056502100001a866f80a0703840403020350056502100001afc7e8088703812401820350056502100001e000000000000000000000000006b";
          DP-2 =
            "00ffffffffffff0006b32027010101010e200104a53c22783b07f0a655539e270e5054b7ef00714f8180814081c081009500b3000101023a801871382d40582c450056502100001e000000fd0028a5c3c329010a202020202020000000fc0056473237380a20202020202020000000ff004e334c4d51533137323436300a012d020318f14b900504030201111213141f2309070783010000a49c80a0703859403020350056502100001a8a4d80a070382c403020350056502100001afe5b80a0703835403020350056502100001a866f80a0703840403020350056502100001afc7e8088703812401820350056502100001e00000000000000000000000000fc";
          HDMI-1 =
            "00ffffffffffff0006b3ad270101010113210103803c2278ea07f0a655539e270e5054b7ef00714f8180814081c081009500b3000101023a801871382d40582c450056502100001e000000fd0028781e8c1e000a202020202020000000fc0056473237380a20202020202020000000ff0052354c4d51533034313730350a012302032bf14d900504030201111213141f403f230907078301000067030c0010000044681a000001012878008a4d80a070382c403020350056502100001afe5b80a0703835403020350056502100001a866f80a0703840403020350056502100001a0000000000000000000000000000000000000000000000000000000000004f";
        };
        config = {
          HDMI-0.enable = false;
          DP-1.enable = false;
          DP-3.enable = false;
          HDMI-1 = {
            enable = true;
            crtc = 2;
            mode = "1920x1080";
            position = "0x0";
            rate = "120.00";
            rotate = "right";
          };
          DP-0 = {
            enable = true;
            crtc = 0;
            mode = "1920x1080";
            position = "3000x0";
            rate = "144.00";
            rotate = "left";
          };
          DP-2 = {
            enable = true;
            primary = true;
            crtc = 1;
            mode = "1920x1080";
            position = "1080x271";
            rate = "165.00";
          };
        };
      };
    };
  };


  services.ssh-agent.enable = true;

  #Picom
  services.picom.enable = true;


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

  services.dunst = {
    enable = true;
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
      updated = "sudo nixos-rebuild switch --flake $HOME/dotfiles/nix/#nixosDesktop";
      sec = "$EDITOR $HOME/dotfiles/nix/nixos/configuration.nix";
      hupdates = "home-manager switch --flake $HOME/dotfiles/home-manager/#simon";
      hme =
        "$EDITOR ${config.home.homeDirectory}/.config/home-manager/homenix/home.nix";
      rm = "trash";
    };
  };

  #Zoxide
  programs.zoxide = { enable = true; };

  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      config = {
        window = {
          border = 0;
          titlebar = false;
        };
        modifier = "Mod4";
        keybindings = lib.mkOptionDefault {
          "Mod4+m" = "exec kitty";
          "Mod4+g" = "exec firefox";
          "Mod4+q" = "kill";
          "Mod4+h" = "focus left";
          "Mod4+j" = "focus down";
          "Mod4+k" = "focus up";
          "Mod4+l" = "focus right";
          "Mod4+Shift+h" = "move left";
          "Mod4+Shift+j" = "move down";
          "Mod4+Shift+k" = "move up";
          "Mod4+Shift+l" = "move right";
          "Mod4+o" = "exec setxkbmap -layout ca multix";
          "Mod4+Shift+o" = "exec setxkbmap -layout us";
          "Mod4+1" = "workspace number $ws1";
          "Mod4+2" = "workspace number $ws2";
          "Mod4+3" = "workspace number $ws3";
          "Mod4+4" = "workspace number $ws4";
          "Mod4+5" = "workspace number $ws5";
          "Mod4+6" = "workspace number $ws6";
          "Mod4+7" = "workspace number $ws7";
          "Mod4+8" = "workspace number $ws8";
          "Mod4+9" = "workspace number $ws9";
          "Mod4+0" = "workspace number $ws10";
          # Move around workspaces
          "Mod4+Shift+1" = "move container to workspace number $ws1";
          "Mod4+Shift+2" = "move container to workspace number $ws2";
          "Mod4+Shift+3" = "move container to workspace number $ws3";
          "Mod4+Shift+4" = "move container to workspace number $ws4";
          "Mod4+Shift+5" = "move container to workspace number $ws5";
          "Mod4+Shift+6" = "move container to workspace number $ws6";
          "Mod4+Shift+7" = "move container to workspace number $ws7";
          "Mod4+Shift+8" = "move container to workspace number $ws8";
          "Mod4+Shift+9" = "move container to workspace number $ws9";
          "Mod4+Shift+0" = "move container to workspace number $ws10";
          # Volume
          "XF86AudioRaiseVolume" =
            "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5% && $refresh_i3status";
          "XF86AudioLowerVolume" =
            "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5% && $refresh_i3status";
          "XF86AudioMute" =
            "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status";
          "XF86AudioMicMute" =
            "exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && $refresh_i3status";

          "XF86AudioPlay" = "exec --no-startup-id playerctl play-pause";
          "XF86AudioNext" = "exec --no-startup-id playerctl next";
          "XF86AudioPrev" = "exec --no-startup-id playerctl previous";
          # Print
          "Print" =
            "exec --no-startup-id maim --select | xclip -selection clipboard -t image/png";
        };
        startup = [
          {
            command = "picom -b";
            always = false;
            notification = false;
          }
          {
            command = "flashfocus";
            always = false;
            notification = false;
          }
          {
            command = "autotiling";
            always = false;
            notification = false;
          }
          #{command = "syncthing"; always = false; notification = false;}
          {
            command = "xset r rate 160 90";
            always = true;
            notification = false;
          }
          {
            command = "systemctl --user start redshift";
            always = false;
            notification = false;
          }
          {
            command = "setxkbmap -layout ca multix";
            always = true;
            notification = false;
          }
          {
            command = "autorandr --load 3screens";
            always = false;
            notification = false;
          }
          {
            command = "shuf -e -n1 ~/Images/nixart/* | xargs feh --bg-fill";
            always = true;
            notification = false;
          }
        ];
        defaultWorkspace = "workspace $ws1";
      };
      extraConfig = ''
        set $ws1 "1"
        set $ws2 "2"
        set $ws3 "3"
        set $ws4 "4"
        set $ws5 "5"
        set $ws6 "6"
        set $ws7 "7"
        set $ws8 "8"
        set $ws9 "9"
        set $ws10 "10"
        workspace $ws1 output DP-2
        workspace $ws2 output DP-0
        workspace $ws3 output HDMI-1'';
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    "./.config/nvim/" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/dotfiles/home-manager/packages/nvim";
      recursive = true;
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

  home.sessionVariables = { EDITOR = "nvim"; };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.config = { allowUnfree = true; };
}
