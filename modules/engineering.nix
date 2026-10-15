{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    freecad
    kicad
    arduino-ide
  ];

  # Access to Arduino boards over /dev/ttyACM* or /dev/ttyUSB*
  users.users.Gunter.extraGroups = [
    "dialout"
  ];
}
