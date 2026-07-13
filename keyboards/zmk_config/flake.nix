{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    zmk-nix = {
      url = "github:lilyinstarlight/zmk-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    zmk-nix,
  }: let
    forAllSystems = nixpkgs.lib.genAttrs (nixpkgs.lib.attrNames zmk-nix.packages);
  in {
    packages = forAllSystems (system: rec {
      default = firmware;

      firmware = zmk-nix.legacyPackages.${system}.buildSplitKeyboard {
        name = "firmware";

        src = nixpkgs.lib.sourceFilesBySuffices self [".board" ".cmake" ".conf" ".defconfig" ".dts" ".dtsi" ".json" ".keymap" ".overlay" ".shield" ".yml" "_defconfig"];
        board = "nice_nano@2.0.0";
        shield = "tbkblu_%PART%";

        zephyrDepsHash = "sha256-1x1yG08jFXUENGHn5hicQrUjIOfal+wdPzllQZT3h1s=";

        # For usb debugging purpose (check keys layout conformity...)
        # extraWestBuildFlags = ["--snippet" "zmk-usb-logging"];

        # Reset firmware
        # westBuildFlags = ["-DSHIELD" "setting_reset"];

        meta = {
          description = "ZMK firmware";
          license = nixpkgs.lib.licenses.mit;
          platforms = nixpkgs.lib.platforms.all;
        };
      };

      # nix run ".#update"
      update = zmk-nix.packages.${system}.update;

      # nix run ".#flash"
      # Help on how to boot into bootloader via shortcircuiting the board pins:
      # https://pandakb.com/guides/how-to-flash-nicenano-firmware/
      flash = zmk-nix.packages.${system}.flash.override {inherit firmware;};
    });

    devShells = forAllSystems (system: {
      default = zmk-nix.devShells.${system}.default;
    });
  };
}
