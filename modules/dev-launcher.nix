{ pkgs, ... }:

let
  projectPicker = pkgs.writeShellApplication {
    name = "project-picker";

    runtimeInputs = with pkgs; [
      rofi
      kitty
      findutils
      coreutils
      direnv
      neovim
    ];

    text = ''
      root="$HOME/Code"

      if [ ! -d "$root" ]; then
        exit 0
      fi

      mapfile -t projects < <(
        {
          # Every top-level directory in ~/Code.
          find "$root" \
            -mindepth 1 \
            -maxdepth 1 \
            -type d \
            -printf '%p\n'

          # Also detect nested projects.
          find "$root" \
            -mindepth 2 \
            -maxdepth 4 \
            \( \
              -type d -name ".git" \
              -o \
              -type f \( \
                -name "flake.nix" \
                -o -name "go.mod" \
                -o -name "pyproject.toml" \
                -o -name "Cargo.toml" \
                -o -name "package.json" \
              \) \
            \) \
            -printf '%h\n'
        } | sort -u
      )

      if [ "''${#projects[@]}" -eq 0 ]; then
        exit 0
      fi

      choices=""

      for project in "''${projects[@]}"; do
        relative="''${project#"$root"/}"
        choices+="''${relative}"$'\n'
      done

      choice="$(
        printf '%s' "$choices" |
          rofi -dmenu -i -p "PROJECT"
      )"

      [ -z "$choice" ] && exit 0

      project="$root/$choice"

      action="$(
        printf '󰆍  Terminal\n  Neovim\n' |
          rofi -dmenu -i -p "$choice"
      )"

      case "$action" in
        *Terminal)
          kitty --directory "$project" &
          ;;

        *Neovim)
          kitty \
            --directory "$project" \
            direnv exec "$project" nvim . &
          ;;
      esac
    '';
  };

in
{
  home.packages = [
    projectPicker
  ];
}
