{
  config,
  lib,
  ...
}:
with lib; {
  normal.window_manager = {
    nixos = {pkgs, ...}: {
      ## Init scripts
      programs = {
        fish = {
          loginShellInit = lib.readFile ./dotfiles/.profile.fish;
        };
        bash = {
          loginShellInit = lib.readFile ./dotfiles/.profile.sh;
        };
      };

      ## Screen
      hardware.acpilight.enable = true;

      ## Sound
      users.groups.audio.members = config.normal.users;
      services.pulseaudio.enable = false;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

      ## Video
      users.groups.video.members = config.normal.users;

      # Mudras/Swhkd
      # No longer need to be root.
      # Members of the **input** group can interact with keyboard.
      users.groups.input.members = config.normal.users;
      systemd.tmpfiles.rules = [
        "z /dev/input 0775 root input - -"
        "z /dev/uinput 0660 root input - -"
      ];

      environment.systemPackages = with pkgs; [
        # Font support
        fontconfig
        # Notification support
        libnotify
        # Audio - pactl audio control cli
        pulseaudio
        pamixer
        ## Screen
        brightnessctl
      ];

      ## Non blocking processes
      security.rtkit.enable = true;

      ###################################
      # Fonts
      fonts = {
        fontconfig = {
          defaultFonts = rec {
            emoji = ["Noto Color Emoji"];
            monospace = [
              "JetBrains Mono Nerd Font Mono"
              "JetBrains Mono NL Nerd Font Mono"
              "NotoSansM Nerd Font Mono"
              "Noto Sans Mono CJK JP"
            ];
            sansSerif = monospace;
            serif = monospace;
          };
        };
        packages = with pkgs; [
          #25.05
          nerd-fonts.jetbrains-mono
          nerd-fonts.noto

          noto-fonts-color-emoji
          noto-fonts-cjk-sans
        ];
      };

      ###################################
      # Theming
      programs.dconf.enable = true;

      environment.etc = {
        # Qt4
        "xdg/Trolltech.conf".text = ''
          [Qt]
          style=GTK+
        '';
      };
      environment.sessionVariables = {
        # QT_WAYLAND_DECORATION = "adwaita";
        QT_WAYLAND_DECORATION = "breeze-dark";
        QT_QPA_PLATFORMTHEME = "gtk3";
      };
    };
    homeManager = {pkgs, ...}: let
      # https://nixos.wiki/wiki/Cursor_Themes
      bibata = pkgs.runCommand "moveUp" {} ''
        mkdir -p $out/share/icons
        ln -s ${pkgs.fetchzip {
          url = "https://github.com/ful1e5/Bibata_Cursor/releases/latest/download/Bibata-Modern-Ice.tar.xz";
          hash = "sha256-SG/NQd3K9DHNr9o4m49LJH+UC/a1eROUjrAQDSn3TAU=";
          # hash = "sha256-wCrIjQo7eKO+piIz88TZDpMnc51iCWDYBR7HBV8/CPI="; # old
        }} $out/share/icons/bibata
      '';
      # Bspwm gnome css fix
      css = ''
        .window-frame, .window-frame:backdrop {
          box-shadow: 0 0 0 black;
          border-style: none;
          margin: 0;
          border-radius: 0;
        }
        .titlebar {
          border-radius: 0;
        }
      '';
    in {
      home.packages = with pkgs; [
        ## Gtk/Qt theme compatibility
        qt6Packages.qt6ct
        # libsForQt5.qt5ct
        # qgnomeplatform
      ];
      # Cursor theming
      home.pointerCursor = {
        size = 24;
        gtk.enable = true;
        x11.enable = true;
        name = "bibata";
        package = bibata;
      };

      # Gnome theming
      gtk = with pkgs; {
        gtk3.extraCss = css;
        gtk4.extraCss = css;
        enable = true;
        theme = {
          name = "adw-gtk3-dark";
          package = adw-gtk3;
        };
        iconTheme = {
          name = "Tela-circle";
          package = tela-circle-icon-theme;
        };
        font = {
          name = "JetBrainsMono";
          size =
            if config.normal.font.enable
            then config.normal.font.size
            else 11;
        };
      };
      dconf = {
        enable = true;
        settings = {
          "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
          };
        };
      };
      # Qt theming
      qt = with pkgs; {
        enable = true;
        platformTheme.name = "qtct";
        style = {
          name = "breeze-dark";
          package = kdePackages.breeze;
        };
      };
    };
  };
}
