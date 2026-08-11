{
  lib,
  inputs,
  ...
}:
with lib; {
  flake-file.inputs = {
    ## Browser
    # NUR - Nix User Repository
    nur.url = "github:nix-community/NUR";
    arkenfox.url = "github:dwarfmaster/arkenfox-nixos";
  };

  normal.browser.firefox = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs.nur.repos.rycee; [
        mozilla-addons-to-nix
      ];
    };
  };
}
