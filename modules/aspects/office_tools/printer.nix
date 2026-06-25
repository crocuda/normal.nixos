################################
## Printer and Scanner
# This module adds the bare minimum for scanner compatibility.
# Support only Epson backend but can be extended if requested.
{
  lib,
  den,
  ...
}:
with lib; {
  normal.office.printers = {
    includes = [
      # Allow unfree software
      (den.batteries.unfree [
        # Epson scanner
        "iscan"
        "iscan-.*"
      ])
    ];
    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        ## Gnome Gui for scanners
        simple-scan
      ];
      ## Printers
      # Enable CUPS to handle printers
      services.printing = {
        enable = true;
        drivers = with pkgs; [
          # following for the 3150
          epson-escpr
          #or
          epson-escpr2

          # cups-filters
          # cups-browsed
        ];
      };
      services.avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
      ## Scanners
      # Enable SANE to handle scanners
      ## Temporally removed/silenced because of anoying unreachable server during update.
      hardware.sane.enable = false;
      hardware.sane.extraBackends = [pkgs.epkowa];
    };
    # Epson support
    homeManager = {pkgs, ...}: {
      home.usergroups = ["scanner" "lp" "cups"];
    };
  };
}
