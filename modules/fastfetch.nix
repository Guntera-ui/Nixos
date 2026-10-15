{ pkgs, ... }:

let
  fastfetch-responsive = pkgs.writeShellScriptBin "fastfetch" ''
    WIDTH="$(${pkgs.ncurses}/bin/tput cols 2>/dev/null || echo 999)"

    if [ "$WIDTH" -lt 115 ]; then
      exec ${pkgs.fastfetch}/bin/fastfetch \
        --config "$HOME/.config/fastfetch/config-compact.jsonc" \
        "$@"
    else
      exec ${pkgs.fastfetch}/bin/fastfetch \
        --config "$HOME/.config/fastfetch/config-full.jsonc" \
        "$@"
    fi
  '';
in
{
  # Our responsive Fastfetch command.
  # The real Fastfetch binary is pulled in automatically as a dependency.
  home.packages = [
    fastfetch-responsive
  ];

  # Declaratively manage Fastfetch files.
  xdg.configFile."fastfetch/config-full.jsonc".source =
    ../config/fastfetch/config-full.jsonc;

  xdg.configFile."fastfetch/config-compact.jsonc".source =
    ../config/fastfetch/config-compact.jsonc;

  xdg.configFile."fastfetch/logo.ansi".source =
    ../config/fastfetch/logo.ansi;
}
