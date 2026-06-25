# Set font size for known apps
{...}: {
  normal.aspects.fonts = {
    nixos = {
      config,
      lib,
      ...
    }: {
      ###################################
      # Options definition
      options.normal.font = with lib; {
        size = mkOption {
          default = 11;
          type = with types; int;
          description = "Overall font size.";
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
      options.normal.font = with lib; {
        size = mkOption {
          default = 11;
          type = with types; int;
          description = "Overall font size.";
        };
      };
    };
  };
  normal.batteries.fontSize = size: {
    nixos = {lib, ...}: {
      config.normal.font.size = size;
    };
  };
}
