{
  inputs,
  den,
  mudras,
  ...
}: {
  flake-file.inputs = {
    mudras.url = "github:crocuda/mudras?ref=dev";
  };

  # Must be imported once,
  # otherwise options will be declared n times,
  # and raise an error.
  imports = [
    # inputs.mudras.flakeModules.default
  ];

  normal.wm.mudras = {
    includes = [
      mudras.aspects.default
      (den.batteries.unfree [
        "via"
      ])
    ];
    ## Alternative: If you don't want to use the flakeModule,
    ## Or prefer the nixosModule:
    #
    # nixos = {pkgs, ...}: {
    # imports = [
    # inputs.mudras.nixosModules.default
    # ];
    # environment.systemPackages = with pkgs; let
    #   inherit (stdenv.hostPlatform) system;
    # in [
    # inputs.mudras.packages.${system}.default
    # ];
    # services.mudras.enable = true;
    # };
    #
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
