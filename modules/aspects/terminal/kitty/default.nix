{normal, ...}: {
  normal.kitty = {
    includes = [
      normal.aspects.fonts
    ];

    nixos = {pkgs, ...}: {
      systemd.user.tmpfiles.rules = [
        "L+ %h/.config/kitty/current-theme.conf - - - - %h/.config/kitty/themes/doom_chad.conf"
      ];
    };

    homeManager = {
      lib,
      pkgs,
      config,
      ...
    }: {
      home.file = {
        ".config/kitty/themes/github_dark_dimmed.conf".source = dotfiles/kitty/github_dark_dimmed.conf;
        ".config/kitty/themes/doom_chad.conf".source = dotfiles/kitty/doom_chad.conf;
        ".config/kitty/themes/doom_hub.conf".source = dotfiles/kitty/doom_hub.conf;
      };
      # Terminal
      programs = with lib; {
        kitty = {
          enable = true;
          extraConfig = mkMerge [
            (builtins.readFile dotfiles/kitty/kitty.conf)
            ''
              map ctrl+j change_font_size ${toString (config.normal.font.size) ? "11"}
              font_size ${toString (config.normal.font.size) ? "11"}
            ''
          ];
        };
      };
    };
  };
}
