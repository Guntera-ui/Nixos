{ pkgs, ... }:

let
  power-menu = pkgs.writeShellScriptBin "power-menu" ''
    CHOICE="$(
      printf '%s\n' \
        "LOCK" \
        "SUSPEND" \
        "LOGOUT" \
        "REBOOT" \
        "SHUTDOWN" |
      ${pkgs.rofi}/bin/rofi \
        -dmenu \
        -p "POWER"
    )"

    confirm() {
      ANSWER="$(
        printf '%s\n' "NO" "YES" |
        ${pkgs.rofi}/bin/rofi \
          -dmenu \
          -p "$1?"
      )"

      [ "$ANSWER" = "YES" ]
    }

    case "$CHOICE" in
      "LOCK")
        ${pkgs.hyprlock}/bin/hyprlock
        ;;

      "SUSPEND")
        ${pkgs.hyprlock}/bin/hyprlock &
        sleep 0.5
        ${pkgs.systemd}/bin/systemctl suspend
        ;;

      "LOGOUT")
        if confirm "LOGOUT"; then
          ${pkgs.hyprland}/bin/hyprctl dispatch exit
        fi
        ;;

      "REBOOT")
        if confirm "REBOOT"; then
          ${pkgs.systemd}/bin/systemctl reboot
        fi
        ;;

      "SHUTDOWN")
        if confirm "SHUTDOWN"; then
          ${pkgs.systemd}/bin/systemctl poweroff
        fi
        ;;
    esac
  '';
in
{
  home.packages = [
    power-menu
  ];
}
