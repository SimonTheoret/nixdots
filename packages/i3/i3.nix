{ lib, laptop ? false }: {
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
        "Mod4+w" = "exec emacsclient -nc";
        # "mod4+u" = "exec emacsclient -nc -s utils";
        "Mod4+Shift+w" = "exec emacs --daemon";
        # "Mod4+Shift+u" = "exec emacs --daemon=utils";
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
          "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +1% && $refresh_i3status";
        "XF86AudioLowerVolume" =
          "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -1% && $refresh_i3status";
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
        {
          command = "syncthing --no-browser";
          always = false;
          notification = false;
        }
        {
          command = "xset r rate 160 90";
          always = true;
          notification = false;
        }
        {
          command = "setxkbmap -layout ca multix";
          always = true;
          notification = false;
        }
        {
          command = "emacs --daemon";
          always = false;
          notification = false;
        }
        # {
        #   command = "emacs --daemon=utils";
        #   always = false;
        #   notification = false;
        # }
      ] ++ lib.optionals (!laptop) [
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
    '' + lib.strings.optionalString (!laptop) ''
      workspace $ws1 output DP-2
      workspace $ws2 output DP-0
      workspace $ws3 output HDMI-0
    '';
  };
}
