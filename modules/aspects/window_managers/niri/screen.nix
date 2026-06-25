{...}: {
  normal.wm.niri = {
    homeManager = {
      lib,
      pkgs,
      config,
      ...
    }: {
      ###################################
      # Options definition
      options.normal.wm.niri = with lib; {
        screen = mkOption {
          type = with types; enum ["21-9" "16-9"];
          description = ''
            Screen size
          '';
          default = "16-9";
        };
      };
    };
  };
  normal.batteries.screenSize = size: {
    nixos = {lib, ...}: {
      config.normal.wm.niri.screen = size;
    };
  };
}
