{ pkgs, ... }:

{
  home.packages = [
    pkgs.qutebrowser
  ];

  xdg.configFile."qutebrowser/config.py" = {
    source = ../config/qutebrowser/config.py;
    force = true;
  };
}
