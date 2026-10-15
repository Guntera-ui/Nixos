{ pkgs, ... }:

{
  programs.thunar = {
    enable = true;

    plugins = with pkgs; [
      thunar-volman
    ];
  };

  programs.xfconf.enable = true;

  # Trash, mounts and removable devices.
  services.gvfs.enable = true;

  # Image/video thumbnails.
  services.tumbler.enable = true;
}
