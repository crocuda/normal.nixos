# Set font size for known apps
{...}: {
  normal.batteries.font = size: {
    nixos = {lib, ...}: {
      ###################################
      # Options definition
      options.crocuda = with lib; {
        font.size = mkOption {
          type = with types; int;
          description = "sozu configuration";
        };
      };
    };
  };
}
