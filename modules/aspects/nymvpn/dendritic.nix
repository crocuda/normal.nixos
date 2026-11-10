{
  lib,
  normal,
  ...
}:
with lib; {
  normal.nymvpn = {
    includes = [
    ];
    nixos = {pkgs, ...}: {
      imports = [./_nixos/default.nix];
    };
    homeManager = {pkgs, ...}: {
    };
  };
}
