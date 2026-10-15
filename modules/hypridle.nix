{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hypridle
  ];

  xdg.configFile."hypr/hypridle.conf" = {
    source = ../config/hypr/hypridle.conf;
    force = true;
  };

  systemd.user.services.hypridle = {
    Unit = {
      Description = "Hyprland idle daemon";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.hypridle}/bin/hypridle";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
