{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  inputs,
  ...
}:
with lib;
  mkIf config.normal.browser.searxng.enable {
    home.file = {
      ".config/websurf/config.lua".source = dotfiles/websurf.lua;
    };
  }
