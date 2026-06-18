{
  description = "normal.nixos - Desktop NixOS configuration modules for paranoids and hypochondriacs.";
  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./modules);
  inputs = {
    ###################################
    ## Dendritic
    den.url = "github:denful/den";
    import-tree.url = "github:denful/import-tree";
    flake-parts = {
      # inputs.nixpkgs-lib.follows = "nixpkgs-lib";
      url = "github:hercules-ci/flake-parts";
    };
    # nixpkgs-lib.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";

    ###################################
    ## NixOs pkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    # nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-deprecated.url = "github:nixos/nixpkgs/nixos-25.11";

    # nirinit = {
    #   url = "github:amaanq/nirinit";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };
}
