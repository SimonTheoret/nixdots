{fontsize? 9}:
{
  enable = true;
  settings = {
    font_family = "FiraCode Nerd Font Mono";
    bold_font = "FiraCode Nerd Font Mono Bold";
    italic_font = "VictorMono NFM SemiBold Italic";
    bold_italic_font = "VictorMono NFM Bold Italic";
    font_size = fontsize;
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
}
