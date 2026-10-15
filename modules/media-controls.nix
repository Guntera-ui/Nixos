{ pkgs, ... }:

let
  volume-up = pkgs.writeShellScriptBin "volume-up" ''
    CURRENT="$(
      ${pkgs.wireplumber}/bin/wpctl get-volume @DEFAULT_AUDIO_SINK@ \
      | ${pkgs.gawk}/bin/awk '{printf "%.0f", $2 * 100}'
    )"

    # Treat the current value as the nearest clean 10,
    # then move exactly one level upward.
    CURRENT=$(( (CURRENT + 5) / 10 * 10 ))
    TARGET=$(( CURRENT + 10 ))

    [ "$TARGET" -gt 100 ] && TARGET=100

    ${pkgs.wireplumber}/bin/wpctl \
      set-volume @DEFAULT_AUDIO_SINK@ "$TARGET%"

    ${pkgs.libnotify}/bin/notify-send \
      -e \
      -a "System" \
      -u low \
      -t 900 \
      -h string:x-canonical-private-synchronous:volume \
      -h int:value:"$TARGET" \
      "VOLUME" \
      "$TARGET%"
  '';

  volume-down = pkgs.writeShellScriptBin "volume-down" ''
    CURRENT="$(
      ${pkgs.wireplumber}/bin/wpctl get-volume @DEFAULT_AUDIO_SINK@ \
      | ${pkgs.gawk}/bin/awk '{printf "%.0f", $2 * 100}'
    )"

    CURRENT=$(( (CURRENT + 5) / 10 * 10 ))
    TARGET=$(( CURRENT - 10 ))

    [ "$TARGET" -lt 0 ] && TARGET=0

    ${pkgs.wireplumber}/bin/wpctl \
      set-volume @DEFAULT_AUDIO_SINK@ "$TARGET%"

    ${pkgs.libnotify}/bin/notify-send \
      -e \
      -a "System" \
      -u low \
      -t 900 \
      -h string:x-canonical-private-synchronous:volume \
      -h int:value:"$TARGET" \
      "VOLUME" \
      "$TARGET%"
  '';

  volume-mute = pkgs.writeShellScriptBin "volume-mute" ''
    STATE="$(
      ${pkgs.wireplumber}/bin/wpctl \
        get-volume @DEFAULT_AUDIO_SINK@
    )"

    if echo "$STATE" | ${pkgs.gnugrep}/bin/grep -q "MUTED"; then

      ${pkgs.wireplumber}/bin/wpctl \
        set-mute @DEFAULT_AUDIO_SINK@ 0

      VOL="$(
        ${pkgs.wireplumber}/bin/wpctl get-volume @DEFAULT_AUDIO_SINK@ \
        | ${pkgs.gawk}/bin/awk '{printf "%.0f", $2 * 100}'
      )"

      ${pkgs.libnotify}/bin/notify-send \
        -e \
        -a "System" \
        -u low \
        -t 900 \
        -h string:x-canonical-private-synchronous:volume \
        -h int:value:"$VOL" \
        "VOLUME" \
        "$VOL%"

    else

      ${pkgs.wireplumber}/bin/wpctl \
        set-mute @DEFAULT_AUDIO_SINK@ 1

      ${pkgs.libnotify}/bin/notify-send \
        -e \
        -a "System" \
        -u low \
        -t 900 \
        -h string:x-canonical-private-synchronous:volume \
        -h int:value:0 \
        "VOLUME" \
        "Muted"

    fi
  '';

  brightness-up = pkgs.writeShellScriptBin "brightness-up" ''
    CURRENT="$(
      ${pkgs.brightnessctl}/bin/brightnessctl -m \
      | ${pkgs.coreutils}/bin/cut -d, -f4 \
      | ${pkgs.coreutils}/bin/tr -d '%'
    )"

    # Snap to nearest logical 10, then move one level.
    CURRENT=$(( (CURRENT + 5) / 10 * 10 ))
    TARGET=$(( CURRENT + 10 ))

    [ "$TARGET" -gt 100 ] && TARGET=100

    ${pkgs.brightnessctl}/bin/brightnessctl \
      set "$TARGET%" >/dev/null

    # Read back the actual hardware value.
    ACTUAL="$(
      ${pkgs.brightnessctl}/bin/brightnessctl -m \
      | ${pkgs.coreutils}/bin/cut -d, -f4 \
      | ${pkgs.coreutils}/bin/tr -d '%'
    )"

    ${pkgs.libnotify}/bin/notify-send \
      -e \
      -a "System" \
      -u low \
      -t 900 \
      -h string:x-canonical-private-synchronous:brightness \
      -h int:value:"$ACTUAL" \
      "BRIGHTNESS" \
      "$ACTUAL%"
  '';

  brightness-down = pkgs.writeShellScriptBin "brightness-down" ''
    CURRENT="$(
      ${pkgs.brightnessctl}/bin/brightnessctl -m \
      | ${pkgs.coreutils}/bin/cut -d, -f4 \
      | ${pkgs.coreutils}/bin/tr -d '%'
    )"

    CURRENT=$(( (CURRENT + 5) / 10 * 10 ))
    TARGET=$(( CURRENT - 10 ))

    # Keep the panel usable instead of dropping to zero.
    [ "$TARGET" -lt 10 ] && TARGET=10

    ${pkgs.brightnessctl}/bin/brightnessctl \
      set "$TARGET%" >/dev/null

    ACTUAL="$(
      ${pkgs.brightnessctl}/bin/brightnessctl -m \
      | ${pkgs.coreutils}/bin/cut -d, -f4 \
      | ${pkgs.coreutils}/bin/tr -d '%'
    )"

    ${pkgs.libnotify}/bin/notify-send \
      -e \
      -a "System" \
      -u low \
      -t 900 \
      -h string:x-canonical-private-synchronous:brightness \
      -h int:value:"$ACTUAL" \
      "BRIGHTNESS" \
      "$ACTUAL%"
  '';
in
{
  home.packages = [
    pkgs.brightnessctl
    pkgs.wireplumber

    volume-up
    volume-down
    volume-mute
    brightness-up
    brightness-down
  ];
}
