
{ ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };

    settings = {
      # Window behavior
      confirm_os_window_close = 0;
      hide_window_decorations = true;
      window_padding_width = 10;

      # Appearance
      background_opacity = "0.88";
      dynamic_background_opacity = true;

      # Cursor
      cursor_shape = "beam";
      cursor = "#f29ac3";
      cursor_text_color = "#0f1018";

      # General
      enable_audio_bell = false;
      scrollback_lines = 10000;

      # Main palette
      background = "#0f1018";
      foreground = "#f4f1ff";

      selection_background = "#8aadf4";
      selection_foreground = "#0f1018";

      url_color = "#7dcfe3";

      # ANSI colors
      color0 = "#161823";
      color1 = "#f29ac3";
      color2 = "#7dcfe3";
      color3 = "#e6c899";
      color4 = "#8aadf4";
      color5 = "#c6a0f6";
      color6 = "#7dcfe3";
      color7 = "#f4f1ff";

      # Bright ANSI colors
      color8 = "#85899b";
      color9 = "#ffb4d5";
      color10 = "#a3e6d5";
      color11 = "#f3ddb1";
      color12 = "#b0c5ff";
      color13 = "#dac0ff";
      color14 = "#a5e9f4";
      color15 = "#ffffff";
    };
  };
}
