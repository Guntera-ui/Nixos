{ ... }:

{
  programs.discord = {
    enable = true;

    settings = {
      SKIP_HOST_UPDATE = true;
      SKIP_MODULE_UPDATE = true;

      MINIMIZE_TO_TRAY = false;
      OPEN_ON_STARTUP = false;
    };
  };
}
