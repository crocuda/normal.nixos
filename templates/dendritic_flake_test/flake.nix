{
  description = "A dendritic flake that uses normal.nixos";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    normal.url = "github:pipelight/normal.nixos?ref=dev";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-utils.url = "github:numtide/flake-utils";
    den.url = "github:denful/den";
  };

  outputs = {
    self,
    nixpkgs,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      flake = rec {
        system = "x86_64-linux";
        nixosConfigurations = {
          # Default module
          default = nixpkgs.lib.nixosSystem {
            specialArgs = {inherit inputs;};

            modules = [
              # Base hardware config for tests
              ../commons/configuration.nix
              ../commons/hardware-configuration.nix

              inputs.normal.denful.normal

              ###################################
              # You may move this module into its own file.
              ({
                pkgs,
                lib,
                config,
                inputs,
                ...
              }: {
                users.users."root" = {
                  initialPassword = "root";
                };
                users.users."anon" = {
                  isNormalUser = true;
                  initialPassword = "anon";
                };
              })
            ];
          };
        };
        packages = {
          default = nixosConfigurations.default.config.system.build.toplevel;
        };
      };
    };
}
