{ pkgs, ... }:

let
  clipboard-picker = pkgs.writeShellScriptBin "clipboard-picker" ''
    selection="$(
      ${pkgs.cliphist}/bin/cliphist list |
      ${pkgs.rofi}/bin/rofi \
        -dmenu \
        -display-columns 2 \
        -p "CLIPBOARD"
    )"

    [ -z "$selection" ] && exit 0

    printf '%s\n' "$selection" |
      ${pkgs.cliphist}/bin/cliphist decode |
      ${pkgs.wl-clipboard}/bin/wl-copy
  '';
in
{
  services.cliphist = {
    enable = true;

    # Keep text + images.
    allowImages = true;

    extraOptions = [
      "-max-dedupe-search"
      "50"
      "-max-items"
      "300"
    ];
  };

  home.packages = [
    clipboard-picker
  ];
}
