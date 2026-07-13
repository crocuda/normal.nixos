{
  lib,
  normal,
  ...
}:
with lib; {
  normal.gaming = {
    includes = [
      normal.bluetooth
      (den.batteries.unfree ["steam.*"])
    ];
    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        # Gnome GamePad navigation
        steam-devices-udev-rules
        bluez
        bluez-tools
      ];
    };
    homeManager = {pkgs, ...}: {
      home.packages = with pkgs; [
        lutris
        bottles
      ];
    };
  };
}
