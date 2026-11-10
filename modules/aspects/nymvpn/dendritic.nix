{
  lib,
  normal,
  ...
}: {
  normal.nymvpn = {
    includes = [
    ];
    nixos = {
      lib,
      config,
      pkgs,
      ...
    }: {
      # imports = [./_nixos/default.nix];
    };
    homeManager = {pkgs, ...}: {
    };
  };
}
