{ pkgs, ... }:

{
  services.swaync = {
    enable = true;

    settings =
      builtins.fromJSON
        (builtins.readFile ../config/swaync/config.json);

    style =
      builtins.readFile ../config/swaync/style.css;
  };

  home.packages = with pkgs; [
    libnotify
  ];
}
