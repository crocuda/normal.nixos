{
  inputs,
  lib,
  ...
}:
# resolved flake inputs as specialArgs
{
  # same inputs code as before
  flake-file.inputs = {
    # make sure you add flake-file dependency.
    flake-file.url = lib.mkDefault "github:denful/flake-file";
  };

  imports = [
    # enable inside-flake and say goodbye to bootstrap
    inputs.flake-file.flakeModules.default

    # start splitting from inputs.nix into other files
  ];

  # generate the same output function we used at bootstrap
  flake-file.outputs = "flake-parts";
}
