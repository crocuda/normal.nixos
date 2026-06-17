{lib, ...}:
with lib; {
  normal.websurf = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        ## Search engine
        # A local search engine that gather other search engine results.
        # It anonimise searches by removing cookies and special params.
        # Furthermore no metadata collection (trackers, blueprint..)
        websurfx
      ];
    };
    homeManager = {pkgs, ...}: {
      home.file = {
        ".config/websurf/config.lua".source = dotfiles/websurf.lua;
      };
    };
  };
}
