{
  inputs,
  den,
  mudras,
  ...
}: {
  flake-file.inputs = {
    mudras.url = "github:crocuda/mudras?ref=dev";
    yofi = {
      url = "github:crocuda/yofi";
      # url = "github:l4l/yofi?ref=09901e75cbdf2147553ab888adde480e57baa0d1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  imports = [
    inputs.mudras.flakeModules.default
  ];

  normal.wm.mudras = {
    includes = [
      mudras.aspects.mudras
      (den.batteries.unfree [
        "via"
      ])
    ];
    ## Alternative: If you don't want to use the flakeModule.
    # nixos = {pkgs, ...}: {
    # imports = [
    # inputs.mudras.nixosModules.default
    # ];
    # services.mudras.enable = true;
    # environment.systemPackages = with pkgs; let
    #   inherit (stdenv.hostPlatform) system;
    # in [
    # inputs.mudras.packages.${system}.default
    # ];
    # };
    homeManager = {
      pkgs,
      config,
      ...
    }: {
      home.file = {
        # Keyboard
        ".config/mudras/config.kdl".source = dotfiles/mudras/config.kdl;
      };
    };
  };
}
