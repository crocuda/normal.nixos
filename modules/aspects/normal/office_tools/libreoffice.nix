{lib, ...}:
with lib; {
  normal.libreoffice = {
    homeManager = {pkgs, ...}: {
      home.packages = with pkgs; [
        libreoffice
      ];
    };
  };
}
