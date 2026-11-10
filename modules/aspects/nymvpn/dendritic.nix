{
  lib,
  normal,
  ...
}: {
  normal.nymvpn = {
    # includes = [
    # ];
    nixos = {
      lib,
      config,
      pkgs,
      ...
    }: {
      imports = [./_nixos/_default.nix];
    };
    homeManager = {pkgs, ...}: {
    };
  };
}
