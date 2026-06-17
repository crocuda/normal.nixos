{lib, ...}:
with lib; {
  normal.flatpak = {
    nixos = {pkgs, ...}: {
      services.flatpak.enable = true;

      xdg.portal = {
        enable = true;
        config.common.default = "*";
        # enable = lib.mkForce false;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-wlr
        ];
      };
    };
    homeManager = {pkgs, ...}: {
      home.sessionVariables = {
        XDG_DATA_DIRS = "$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";
      };
    };
  };
}
