{ config, lib, pkgs, ... }:

{

  imports = [ ../../home-common.nix ];

  home.packages = with pkgs; [ flashfocus autotiling ];

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

  #Picom
  services.picom.enable = true;

  #dunst notifications
  services.dunst = { enable = true; };

  #i3
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
          "Mod4+n" = "exec obsidian";
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

}
