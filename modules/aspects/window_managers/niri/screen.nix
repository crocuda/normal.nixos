{...}: {
  normal.wm.niri = {
    nixos = {
      config,
      lib,
      ...
    }: {
      ###################################
      # Options definition
      options.normal.wm.niri = with lib; {
        screen = mkOption {
          type = with types; enum ["21-9" "16-9"];
          description = "Screen size";
          default = "16-9";
        };
      };
    };
    homeManager = {
      config,
      lib,
      ...
    }: {
      ###################################
      # Options definition
      options.normal.wm.niri = with lib; {
        screen = mkOption {
          type = with types; enum ["21-9" "16-9"];
          description = "Screen size";
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
