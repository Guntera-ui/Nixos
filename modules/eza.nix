{ pkgs, ... }:

let
  eza = "env -u EZA_COLORS -u LS_COLORS eza";
in
{
  home.packages = [
    pkgs.eza
  ];

  xdg.configFile."eza/theme.yml" = {
    source = ../config/eza/theme.yml;
  };

  programs.zsh.shellAliases = {
    ls = "${eza} --icons=auto --group-directories-first";

    ll = "${eza} -lh --icons=auto --group-directories-first";

    la = "${eza} -lah --icons=auto --group-directories-first";

    lt = "${eza} --tree --level=2 --icons=auto --group-directories-first";

    ltt = "${eza} --tree --level=3 --icons=auto --group-directories-first";
  };
}
