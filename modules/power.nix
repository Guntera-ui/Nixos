{ ... }:

{
  powerManagement.enable = true;

  services.power-profiles-daemon.enable = false;

  services.tlp = {
    enable = true;

    settings = {
      # Dynamic frequency scaling on both AC and battery.
      CPU_SCALING_GOVERNOR_ON_AC = "schedutil";
      CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";

      # Keep Ryzen boost available when plugged in.
      CPU_BOOST_ON_AC = 1;

      # Save power and reduce heat on battery.
      CPU_BOOST_ON_BAT = 1;
    };
  };
}
