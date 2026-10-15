{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hyprlock
  ];

  xdg.configFile."hypr/hyprlock.conf" = {
    source = ../config/hypr/hyprlock.conf;
  };
}
