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
    environment.systemPackages = with pkgs; [
      ## Search engine
      # A local search engine that gather other search engine results.
      # It anonimise searches by removing cookies and special params.
      # Furthermore no metadata collection (trackers, blueprint..)
      websurf
    ];
  }
