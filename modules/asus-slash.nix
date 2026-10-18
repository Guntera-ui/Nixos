{ pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "slash-next" ''
      set -euo pipefail

      current="$(asusctl slash get | ${pkgs.gawk}/bin/awk -F ': ' '$1 == "Mode" {print $2; exit}')"

      next="$(asusctl slash list | ${pkgs.gawk}/bin/awk -v current="$current" '
        {
          modes[++n] = $0
          if ($0 == current) position = n
        }
        END {
          if (n == 0) exit 1
          print modes[(position % n) + 1]
        }
      ')"

      asusctl slash set --enable --mode "$next"

      ${pkgs.libnotify}/bin/notify-send \
        "Slash Lighting" "$next" || true
    '')
  ];
}
