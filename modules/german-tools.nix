{ pkgs, ... }:

let
  germanLookup = pkgs.writeShellApplication {
    name = "german-lookup";

    runtimeInputs = with pkgs; [
      rofi
      qutebrowser
    ];

    text = ''
      query="$(
        rofi -dmenu -p "DEUTSCH"
      )"

      [ -z "$query" ] && exit 0


      # URL-encode without needing another package.
      urlencode() {
        local LC_ALL=C
        local input="$1"
        local output=""
        local char

        for (( i = 0; i < ''${#input}; i++ )); do
          char="''${input:i:1}"

          case "$char" in
            [a-zA-Z0-9.~_-])
              output+="$char"
              ;;

            " ")
              output+="%20"
              ;;

            *)
              printf -v hex '%%%02X' "'$char"
              output+="$hex"
              ;;
          esac
        done

        printf '%s' "$output"
      }

      encoded="$(urlencode "$query")"

      source="$(
        printf '%s\n' \
          "󰓆  DWDS — meaning & examples" \
          "󰗊  Duden — spelling & grammar" \
          "󰗚  LEO — German ↔ English" \
          "󰗃  Wiktionary — grammar & etymology" \
          "󰘿  Verbformen — conjugation" |
          rofi -dmenu -i -p "$query"
      )"

      [ -z "$source" ] && exit 0

      case "$source" in
        *DWDS*)
          url="https://www.dwds.de/wb/$encoded"
          ;;

        *Duden*)
          url="https://www.duden.de/suchen/dudenonline/$encoded"
          ;;

        *LEO*)
          url="https://dict.leo.org/german-english/$encoded"
          ;;

        *Wiktionary*)
          url="https://de.wiktionary.org/wiki/$encoded"
          ;;

        *Verbformen*)
          url="https://www.verbformen.de/konjugation/?w=$encoded"
          ;;

        *)
          exit 0
          ;;
      esac

      qutebrowser "$url" &
    '';
  };

in
{
  home.packages = [
    germanLookup
  ];
}
