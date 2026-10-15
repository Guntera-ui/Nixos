{ pkgs, ... }:

let
  thunarClean = pkgs.writeShellApplication {
    name = "thunar-clean";

    runtimeInputs = with pkgs; [
      thunar
      xfconf
    ];

    text = ''
      set_bool() {
        local property="$1"
        local value="$2"

        if xfconf-query \
          --channel thunar \
          --property "$property" \
          >/dev/null 2>&1
        then
          xfconf-query \
            --channel thunar \
            --property "$property" \
            --set "$value"
        else
          xfconf-query \
            --channel thunar \
            --property "$property" \
            --create \
            --type bool \
            --set "$value"
        fi
      }

      set_string() {
        local property="$1"
        local value="$2"

        if xfconf-query \
          --channel thunar \
          --property "$property" \
          >/dev/null 2>&1
        then
          xfconf-query \
            --channel thunar \
            --property "$property" \
            --set "$value"
        else
          xfconf-query \
            --channel thunar \
            --property "$property" \
            --create \
            --type string \
            --set "$value"
        fi
      }


      # =========================================================
      # WINDOW
      # =========================================================

      # Hyprland owns the window chrome.
      set_bool "/misc-use-csd" false

      set_bool "/last-menubar-visible" false
      set_bool "/last-statusbar-visible" false

      set_bool "/misc-directory-specific-settings" false
      set_bool "/misc-always-show-tabs" false


      # =========================================================
      # TOOLBAR
      # =========================================================

      # Minimal navigation only:
      #
      #   ←  →  ↑   /home/Gunter/...
      #
      set_string \
        "/last-toolbar-items" \
        "menu:0,back:1,forward:1,open-parent:1,open-home:0,new-tab:0,new-window:0,toggle-split-view:0,undo:0,redo:0,zoom-out:0,zoom-in:0,zoom-reset:0,view-as-icons:0,view-as-detailed-list:0,view-as-compact-list:0,view-switcher:0,show-hidden:0,location-bar:1,reload:0,search:0"

      set_string \
        "/last-location-bar" \
        "ThunarLocationEntry"

      # Slightly larger toolbar icons.
      set_bool "/misc-small-toolbar-icons" false

      # Use the custom Gunter-Fractal symbolic arrows.
      set_bool "/misc-symbolic-icons-in-toolbar" true


      # =========================================================
      # SIDEBAR
      # =========================================================

      set_string \
        "/last-side-pane" \
        "ThunarShortcutsPane"

      # Use the full custom place icons.
      set_bool "/misc-symbolic-icons-in-sidepane" false

      # Bigger than before.
      set_string \
        "/shortcuts-icon-size" \
        "THUNAR_ICON_SIZE_24"

      set_bool "/shortcuts-icon-emblems" false


      # =========================================================
      # FILE VIEW
      # =========================================================

      set_string \
        "/default-view" \
        "ThunarDetailsView"

      set_string \
        "/last-view" \
        "ThunarDetailsView"

      # Larger custom icons in the details list.
      set_string \
        "/last-details-view-zoom-level" \
        "THUNAR_ZOOM_LEVEL_50_PERCENT"

      set_string \
        "/last-details-view-visible-columns" \
        "THUNAR_COLUMN_NAME,THUNAR_COLUMN_SIZE,THUNAR_COLUMN_DATE_MODIFIED"

      set_bool "/misc-folders-first" true
      set_bool "/misc-thumbnail-draw-frames" false


      # =========================================================
      # APPEARANCE
      # =========================================================

      # Widget theme.
      # Icon theme itself is handled globally by modules/icons.nix.
      export GTK_THEME="GunterThunar"

      exec thunar "$@"
    '';
  };

in
{
  home.packages = [
    thunarClean
  ];

  xdg.dataFile."themes/GunterThunar/gtk-3.0/gtk.css" = {
    source = ../config/gtk/gunter-thunar/gtk.css;
    force = true;
  };
}
