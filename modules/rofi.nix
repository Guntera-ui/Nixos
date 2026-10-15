{ pkgs, ... }:

{
  home.packages = with pkgs; [
    rofi
    xdg-utils
  ];

  xdg.configFile."rofi/config.rasi".source =
    ../config/rofi/config.rasi;

  xdg.configFile."rofi/theme.rasi".source =
    ../config/rofi/theme.rasi;

  xdg.configFile."rofi/nixos.svg".source =
    ../config/rofi/nixos.svg;
}
