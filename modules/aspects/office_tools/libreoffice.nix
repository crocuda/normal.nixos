{lib, ...}:
with lib; {
  normal.office.libreoffice = {
    homeManager = {pkgs, ...}: {
      home.packages = with pkgs; [
        libreoffice
      ];
    };
  };
}
