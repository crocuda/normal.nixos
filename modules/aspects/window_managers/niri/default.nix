{
  inputs,
  lib,
  den,
  normal,
  ...
}:
with lib; {
  flake-file.inputs = {
    mudras.url = "github:pipelight/mudras?ref=dev";
    yofi = {
      # url = "github:l4l/yofi";
      url = "github:l4l/yofi?ref=09901e75cbdf2147553ab888adde480e57baa0d1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  normal.wm.niri = {
    ## Add Users to admin groups.
    policies.to-host = {user, ...}: {
      nixos = {...}: {
        users.groups = {
          input.members = [];
        };
        users.users.${user.userName} = {
          extraGroups = [
            "input"
          ];
        };
      };
    };
    includes = [
      normal.wm.base
      normal.wm.niri.policies.to-host
      (den.batteries.unfree [
        "via"
      ])
    ];
    nixos = {
      pkgs,
      user,
      ...
    }: {
      # Mudras/Swhkd
      # No longer need to be root.
      # Members of the **input** group can interact with keyboard.
      systemd.tmpfiles.rules = [
        "z /dev/input 0775 root input - -"
        "z /dev/uinput 0660 root input - -"
      ];

      environment.systemPackages = with pkgs; let
        inherit (stdenv.hostPlatform) system;
      in [
        ## Window manager
        niri
        xwayland-satellite
        ## Niri plugin
        # inputs.nirinit.packages.${system}.default

        ## keyboard daemons
        inputs.mudras.packages.${system}.default
        # wlr-which-key

        ## Bars
        waybar

        ## Night light
        # redshift
        gammastep

        wl-clipboard

        ## Keyboard utils
        via
        wev
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
          # Keyboard
          ".config/mudras/config.kdl".source = dotfiles/mudras/config.kdl;

          # App launcher
          ".config/yofi".source = dotfiles/yofi;

          ## Window Manager (niri)
          ".config/niri/config.kdl".source = dotfiles/niri/config.kdl;
          ".config/niri/outputs.kdl".source = dotfiles/niri/outputs.kdl;
          # submaps
          ".config/niri/main.kdl".source = dotfiles/niri/main.kdl;
          ".config/niri/manageable.kdl".source = dotfiles/niri/manageable.kdl;

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
