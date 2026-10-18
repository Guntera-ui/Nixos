{ ... }:

{
  systemd.user.targets.hyprland-session = {
    description = "Hyprland graphical session";

    bindsTo = [
      "graphical-session.target"
    ];

    wants = [
      "graphical-session-pre.target"
    ];

    after = [
      "graphical-session-pre.target"
    ];
  };
}
