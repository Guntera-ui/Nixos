{ pkgs, ... }:

let
  screenshot-full = pkgs.writeShellScriptBin "screenshot-full" ''
    DIR="$HOME/Pictures/Screenshots"
    ${pkgs.coreutils}/bin/mkdir -p "$DIR"

    FILE="$DIR/$(${pkgs.coreutils}/bin/date '+%Y-%m-%d_%H-%M-%S').png"

    if ${pkgs.grim}/bin/grim "$FILE"; then
      ${pkgs.wl-clipboard}/bin/wl-copy --type image/png < "$FILE"

      ${pkgs.libnotify}/bin/notify-send \
        -a "Screenshot" \
        -u low \
        -t 2500 \
        -i "$FILE" \
        "Screenshot saved" \
        "$FILE"
    else
      ${pkgs.libnotify}/bin/notify-send \
        -a "Screenshot" \
        -u critical \
        "Screenshot failed"

      exit 1
    fi
  '';

  screenshot-region = pkgs.writeShellScriptBin "screenshot-region" ''
    DIR="$HOME/Pictures/Screenshots"
    ${pkgs.coreutils}/bin/mkdir -p "$DIR"

    GEOMETRY="$(${pkgs.slurp}/bin/slurp)"

    if [ $? -ne 0 ] || [ -z "$GEOMETRY" ]; then
      exit 0
    fi

    FILE="$DIR/$(${pkgs.coreutils}/bin/date '+%Y-%m-%d_%H-%M-%S').png"

    if ${pkgs.grim}/bin/grim -g "$GEOMETRY" "$FILE"; then
      ${pkgs.wl-clipboard}/bin/wl-copy --type image/png < "$FILE"

      ${pkgs.libnotify}/bin/notify-send \
        -a "Screenshot" \
        -u low \
        -t 2500 \
        -i "$FILE" \
        "Screenshot saved" \
        "$FILE"
    else
      ${pkgs.libnotify}/bin/notify-send \
        -a "Screenshot" \
        -u critical \
        "Screenshot failed"

      exit 1
    fi
  '';

  screenshot-clipboard = pkgs.writeShellScriptBin "screenshot-clipboard" ''
    GEOMETRY="$(${pkgs.slurp}/bin/slurp)"

    if [ $? -ne 0 ] || [ -z "$GEOMETRY" ]; then
      exit 0
    fi

    if ${pkgs.grim}/bin/grim -g "$GEOMETRY" - \
      | ${pkgs.wl-clipboard}/bin/wl-copy --type image/png
    then
      ${pkgs.libnotify}/bin/notify-send \
        -a "Screenshot" \
        -u low \
        -t 2000 \
        "Screenshot copied" \
        "Image copied to clipboard"
    else
      ${pkgs.libnotify}/bin/notify-send \
        -a "Screenshot" \
        -u critical \
        "Screenshot failed"

      exit 1
    fi
  '';
in
{
  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard

    screenshot-full
    screenshot-region
    screenshot-clipboard
  ];
}
