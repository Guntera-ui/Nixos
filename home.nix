{ config, pkgs, ... }:

{
  imports = [
    ./modules/starship.nix
    ./modules/waybar.nix
    ./modules/fastfetch.nix
    ./modules/rofi.nix
    ./modules/fzf.nix
    ./modules/hyprland.nix
    ./modules/screenshots.nix
    ./modules/hyprlock.nix
    ./modules/hypridle.nix
    ./modules/swaync.nix
    ./modules/cliphist.nix
    ./modules/media-controls.nix
    ./modules/power-menu.nix
    ./modules/qutebrowser.nix
    ./modules/desktop-integration.nix
    ./modules/neovim.nix
    ./modules/direnv.nix
    ./modules/eza.nix
    ./modules/hyprpolkitagent.nix
    ./modules/dev-launcher.nix
    ./modules/german-tools.nix
    ./modules/thunar.nix
#    ./modules/icons.nix
    ./modules/cursor.nix
];

  home.username = "Gunter";
  home.homeDirectory = "/home/Gunter";
  home.stateVersion = "26.05";
  home.sessionPath = [
  	"$HOME/.local/bin"
	];
  programs.zsh = {
    enable = true;

    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec start-hyprland
      fi
    '';

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };
}
