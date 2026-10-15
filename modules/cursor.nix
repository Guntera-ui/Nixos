{ pkgs, ... }:

let
  # Original XCursor theme.
  #
  # Pinned to the revision used by a current Hyprland/HyDE setup
  # that specifically tracks the corrected hotspot version.
  futureXcursorSrc = builtins.fetchGit {
    url = "https://github.com/yeyushengfan258/Future-cursors.git";
    rev = "587c14d2f5bd2dc34095a4efbb1a729eb72a1d36";
  };

  # Native Hyprcursor port.
  futureHyprcursorSrc = builtins.fetchGit {
    url = "https://gitlab.com/Pummelfisch/future-cyan-hyprcursor.git";
    rev = "cf4126d17f4520aceb688d8a60daca4a1f0b9e80";
  };

  futureCursors = pkgs.runCommandLocal "future-cursors" {} ''
    mkdir -p $out/share/icons

    # ----------------------------------------------------------
    # XCURSOR
    # GTK / XWayland / applications that don't use Hyprcursor.
    # ----------------------------------------------------------

    mkdir -p $out/share/icons/Future-cursors

    cp -r \
      ${futureXcursorSrc}/dist/. \
      $out/share/icons/Future-cursors/


    # ----------------------------------------------------------
    # HYPRCURSOR
    # Native Hyprland cursor.
    # ----------------------------------------------------------

    cp -r \
      ${futureHyprcursorSrc}/Future-Cyan-Hyprcursor_Theme \
      $out/share/icons/Future-Cyan-Hyprcursor_Theme
  '';

in
{
  home.packages = [
    futureCursors
  ];


  # ============================================================
  # GTK / XCURSOR
  # ============================================================

  home.pointerCursor = {
    enable = true;

    package = futureCursors;
    name = "Future-cursors";

    size = 24;

    gtk.enable = true;
    x11.enable = true;
  };


  # ============================================================
  # HYPRLAND
  # ============================================================

  home.sessionVariables = {
    HYPRCURSOR_THEME = "Future-Cyan-Hyprcursor_Theme";

    # Native Hyprcursor sizes don't visually correspond 1:1
    # with XCursor sizes.
    HYPRCURSOR_SIZE = "34";

    XCURSOR_THEME = "Future-cursors";
    XCURSOR_SIZE = "24";
  };
}
