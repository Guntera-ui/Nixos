
{ pkgs, ... }:

let
  batteryWatcher = pkgs.writeShellApplication {
    name = "battery-alert-watcher";

    runtimeInputs = with pkgs; [
      upower
      libnotify
      gawk
      gnugrep
      coreutils
    ];

    text = ''
      battery="$(upower -e | grep -m1 '/battery_' || true)"
      [ -n "$battery" ] || exit 0

      last_alert=0

      check_battery() {
        local info percent state

        info="$(upower -i "$battery")" || return

        percent="$(printf '%s\n' "$info" |
          awk '$1 == "percentage:" {
            gsub(/%/, "", $2)
            print int($2)
            exit
          }')"

        state="$(printf '%s\n' "$info" |
          awk '$1 == "state:" {print $2; exit}')"

        [ -n "$percent" ] || return

        # Reset alerts while charging.
        if [ "$state" != "discharging" ]; then
          last_alert=0
          return
        fi

        if (( percent <= 15 )); then
          if (( last_alert < 2 )); then
            notify-send \
              -a "Battery" \
              -u critical \
              -i battery-caution \
              "Critical battery: $percent%" \
              "Connect the charger. Shutdown at 8%." || true

            last_alert=2
          fi

        elif (( percent <= 20 )); then
          if (( last_alert < 1 )); then
            notify-send \
              -a "Battery" \
              -u normal \
              -i battery-low \
              "Low battery: $percent%" \
              "Connect the charger soon." || true

            last_alert=1
          fi

        else
          last_alert=0
        fi
      }

      check_battery

      # Event-driven battery monitoring.
      while IFS= read -r _; do
        check_battery
      done < <(stdbuf -oL upower --monitor)
    '';
  };

in
{
  systemd.user.services.battery-alerts = {
    Unit = {
      Description = "SwayNC battery notifications";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart =
        "${batteryWatcher}/bin/battery-alert-watcher";

      Restart = "on-failure";
      RestartSec = 5;
    };

    Install.WantedBy = [
      "graphical-session.target"
    ];
  };
}
