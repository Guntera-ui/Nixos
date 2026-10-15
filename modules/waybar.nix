{ ... }:

{
  programs.waybar = {
    enable = true;

    # Hyprland launches Waybar.
    systemd.enable = false;
  };

  xdg.configFile."waybar/config" = {
    source = ../config/waybar/config.jsonc;
    force = true;
  };

  xdg.configFile."waybar/style.css" = {
    source = ../config/waybar/style.css;
    force = true;
  };
}
