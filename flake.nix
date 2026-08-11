# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);

  inputs = {
    arkenfox.url = "github:dwarfmaster/arkenfox-nixos";
    den.url = "github:denful/den";
    flake-file.url = "github:vic/flake-file";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    import-tree.url = "github:denful/import-tree";
    mudras.url = "github:crocuda/mudras?ref=dev";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-deprecated.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    rustmission.url = "github:intuis/rustmission";
    rycee.url = "github:nix-community/nur-combined?dir=repos/rycee";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    yofi = {
      url = "github:crocuda/yofi";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
