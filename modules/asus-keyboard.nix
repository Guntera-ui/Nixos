{ pkgs, ... }:

{
  systemd.services.asusd.preStart = ''
    ${pkgs.hidapitester}/bin/hidapitester \
      --vidpid 0B05/19B6 \
      --open \
      --send-feature 70,1 \
      --close
  '';
}
