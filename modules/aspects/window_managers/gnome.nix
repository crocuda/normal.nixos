{
  lib,
  normal,
  ...
}:
with lib; {
  normal.wm.gnome = {
    includes = [
      normal.wm.base
    ];
    nixos = {pkgs, ...}: {
      services.gnome.gnome-settings-daemon.enable = true;
      environment.systemPackages = with pkgs;
      with pkgs; [
        gnome-control-center
        gnome-initial-setup
        gnome-session
        gnome-shell
        gnome-bluetooth
        gnome-backgrounds
        gnome-power-manager
        gnome-maps

        gnome.nixos-gsettings-overrides
        gnome-settings-daemon
        gnome-menus

        nautilus
        emote
      ];
      # Temporary fix one line full gnome installation
      # services.xserver.desktopManager.gnome.enable = true;
      environment.gnome.excludePackages = with pkgs; [
        gnome-photos
        gnome-tour
        gedit # text editor
        # seahorse
        cheese # webcam tool
        gnome-music
        gnome-terminal
        epiphany # web browser
        geary # email reader
        # evince # document viewer
        gnome-characters
        totem # video player
        # Games
        tali # poker game
        iagno # go game
        hitori # sudoku game
        atomix # puzzle game
      ];
    };

    homeManager = {pkgs, ...}: {
      home.packages = with pkgs; [
        ## Gnome minimal apps
        # image viewer
        loupe
        # pdf viewer
        evince

        # invoice
      ];

      dconf.settings = {
        "org/gnome/shell" = {
          favorite-apps = [
            "firefox.desktop"
            # "fish.desktop"
            "lutris.desktop"
            "nautilus.desktop"
            "settings.deskto"
          ];
        };
        "org/gnome/settings-daemon/plugins/color" = {
          night-light-enabled = true;
        };

        # Remove gtk window buttons
        "org/gnome/desktop/wm/preferences" = {
          button-layout = "";
          # button-layout = "minimize,maximize,close";
        };
      };
    };

    # Default apps
    xdg.mimeApps = {
      enable = true;
      associations.added = {
        "application/pdf" = ["org.gnome.Evince.desktop"];
        "application/images" = ["org.gnome.Loupe.desktop"];
        "image/jpeg" = ["org.gnome.Loupe.desktop"];
        "x-scheme-handler/tg" = ["org.telegram.desktop.desktop"];
      };
      defaultApplications = {
        "application/pdf" = ["org.gnome.Evince.desktop"];
        "application/images" = ["org.gnome.Loupe.desktop"];
        "image/jpeg" = ["org.gnome.Loupe.desktop"];
        "x-scheme-handler/tg" = ["org.telegram.desktop.desktop"];
      };
    };
  };
}
