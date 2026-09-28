{
  inputs,
  lib,
  den,
  normal,
  ...
}:
with lib; {
  flake-file.inputs = {
    mudras.url = "github:crocuda/mudras?ref=dev";
    yofi = {
      url = "github:crocuda/yofi";
      # url = "github:l4l/yofi?ref=09901e75cbdf2147553ab888adde480e57baa0d1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  normal.wm.mudras = {
    includes = [
      normal.wm.mudras.policies.to-host
      (den.batteries.unfree [
        "via"
      ])
    ];
    nixos = {
      pkgs,
      user,
      ...
    }: {
      environment.systemPackages = with pkgs; let
        inherit (stdenv.hostPlatform) system;
      in [
        ## keyboard daemons
        inputs.mudras.packages.${system}.default
        # wlr-which-key
        ## Keyboard utils
        via
      ];
      services.mudras.enable = true;
    };
  };
  homeManager = {
    lib,
    pkgs,
    config,
    ...
  }: {
    home.file = {
      # Keyboard
      ".config/mudras/config.kdl".source = dotfiles/mudras/config.kdl;
    };
  };
}
