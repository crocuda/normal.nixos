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
      imports = [./_default.nix];
    };
    homeManager = {pkgs, ...}: {
    };
  };
}
