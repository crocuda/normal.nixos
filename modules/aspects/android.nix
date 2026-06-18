################################
## Android
# This module enable compatibility for devices under GrapheneOs.
{...}: {
  normal.android = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        # Adb sideload
        android-tools

        # Mount android phones
        adbfs-rootless
        jmtpfs
        glib

        # Work with usb devices
        usbutils
      ];
    };
  };
}
