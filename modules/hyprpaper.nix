{ ... }:

{
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    splash = false

    wallpaper {
      monitor =
      path = ${../config/wallpapers/wallpaper.png}
      fit_mode = cover
    }
  '';
}
