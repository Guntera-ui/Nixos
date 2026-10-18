{ ... }:

{
  services.upower = {
    enable = true;

    usePercentageForPolicy = true;

    percentageLow = 20;
    percentageCritical = 15;
    percentageAction = 8;

    criticalPowerAction = "PowerOff";
  };
}
