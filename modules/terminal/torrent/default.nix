{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
  mkIf config.normal.terminal.torrent.enable {
    nixos = {pkgs, ...}: {
      ################################
      ### Torrent
      services.transmission = {
        enable = true;
        package = pkgs.transmission_4;
      };
    };
    homeManager = {pkgs, ...}: {
      home.packages = with pkgs; [
        # Torrenting
        # inputs.rustmission.packages.${system}.default
        rustmission
      ];
      home.file = {
        ".config/rustmission/config.toml".source = dotfiles/rustmission/config.toml;
      };
    };
  }
