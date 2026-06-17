{lib, ...}:
with lib; {
  normal.gaming = {
    includes = [
      (den.batteries.unfree ["steam.*"])
    ];
    homeManager = {pkgs, ...}: {
      home.packages = with pkgs; [
        lutris
        bottles
      ];
    };
  };
}
