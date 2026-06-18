# This is now real Nix code, use let bindings, { lib, ... } etc.
# best practice is to split this inputs.nix into other modules
{
  inputs,
  lib,
  ...
}:
# resolved flake inputs as specialArgs
{
  flake-file.inputs = {
    ###################################
    ## Dendritic
    den.url = "github:denful/den";
    import-tree.url = "github:denful/import-tree";
    flake-parts = {
      # inputs.nixpkgs-lib.follows = "nixpkgs-lib";
      url = "github:hercules-ci/flake-parts";
    };
    # make sure you add flake-file dependency.
    # flake-file.url = "github:denful/flake-file";
    flake-file.url = lib.mkDefault "github:vic/flake-file";

    ###################################
    ## NixOs pkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    # nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-deprecated.url = "github:nixos/nixpkgs/nixos-25.11";
  };

  imports = [
    # enable inside-flake and say goodbye to bootstrap
    inputs.flake-file.flakeModules.dendritic
  ];
}
