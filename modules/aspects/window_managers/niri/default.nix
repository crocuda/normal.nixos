{
  inputs,
  lib,
  den,
  normal,
  ...
}:
with lib; {
  flake-file.inputs = {
    mudras.url = "github:crocuda/mudras?ref=dev";
    yofi = {
      url = "github:crocuda/yofi";
      # url = "github:l4l/yofi?ref=09901e75cbdf2147553ab888adde480e57baa0d1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  normal.wm.niri = {
    includes = [
      normal.wm.base
      normal.wm.mudras
    ];
    nixos = {
      pkgs,
      user,
      ...
    }: {
      programs.niri.enable = true;

      # Niri systemd unit
      #
      systemd.services.niri = {
        enable = true;
        description = "A scrollable-tiling Wayland compositor";
        # bindsTo = ["graphical-session.target"];
        after = ["graphical-session-pre.target"];
        wants = [
          "xdg-desktop-autostart.target"
          # "graphical-session-pre.target"
        ];
        before = [
          "xdg-desktop-autostart.target"
          ## Error "graphical-session.target" not found:
          ## - when not using a session manager
          ## - or when logging through tty
          # "graphical-session.target"
        ];
        serviceConfig = {
          Slice = "session.slice";
          Type = "notify";
          ExecStart = "niri --session";
        };
      };

      systemd.services.waybar = {
        enable = true;
        description = "";
        after = [
          "graphical-session-pre.target"
        ];
        wantedBy = ["niri.service"];
        wants = [
          "xdg-desktop-autostart.target"
        ];
        before = [
          "xdg-desktop-autostart.target"
        ];
        serviceConfig = {
          Slice = "session.slice";
          Type = "notify";
          ExecStart = [
            "waybar -c ~/.config/waybar/main.jsonc"
            "waybar -c ~/.config/waybar/metrics.jsonc"
            "waybar -c ~/.config/waybar/workspaces.jsonc"
          ];
        };
      };

      environment.systemPackages = with pkgs; [
        ## Window manager
        niri
        xwayland-satellite

        wl-clipboard

        ## Niri plugin
        # inputs.nirinit.packages.${system}.default

        ## Bars
        waybar

        ## Night light
        # redshift
        gammastep
      ];

      services.udev.packages = with pkgs; [
        via
      ];

      ## Do not use following option as it maybe tweaks systemd too much for our needs.
      # programs.niri.enable = true;

      ## Restore niri session (desktop placement and window sizes).
      # services.nirinit = {
      # enable = true;
      # settings = {
      # };
      # };
    };
    homeManager = {
      lib,
      pkgs,
      config,
      ...
    }: {
      ## Remove gtk window buttons
      dconf = {
        enable = true;
        settings = {
          "org/gnome/desktop/wm/preferences" = {
            button-layout = "";
          };
        };
      };

      home.file = let
        screen = config.normal.wm.niri.screen;
      in
        {
          # App launcher
          ".config/yofi".source = dotfiles/yofi;

          ## Window Manager (niri)
          ".config/niri/config.kdl".source = dotfiles/niri/config.kdl;
          ".config/niri/outputs.kdl".source = dotfiles/niri/outputs.kdl;
          # submaps
          ".config/niri/main.kdl".source = dotfiles/niri/main.kdl;
          ".config/niri/manageable.kdl".source = dotfiles/niri/manageable-${screen}.kdl;

          # Notifications
          ".config/dunst/dunstrc".source = dotfiles/dunstrc;
        }
        // {
          # Bars
          ".config/waybar/main.jsonc".source = dotfiles/waybar/${screen}/main.jsonc;
          ".config/waybar/workspaces.jsonc".source = dotfiles/waybar/${screen}/workspaces.jsonc;
          ".config/waybar/metrics.jsonc".source = dotfiles/waybar/${screen}/metrics.jsonc;
          ".config/waybar/style.css".source = dotfiles/waybar/${screen}/style.css;
        };

      home.packages = with pkgs; let
        image_to_grayscale = pkgs.writeShellScriptBin "image_to_grayscale" ''
          convert $1 -colorspace gray $1.gray.jpeg
        '';
      in [
        # Yofi and dependencies
        inputs.yofi.packages.${system}.default

        # Wallpapers
        awww
        image_to_grayscale

        # notifications
        dunst
      ];
    };
  };
}
