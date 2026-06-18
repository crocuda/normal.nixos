{
  lib,
  inputs,
  ...
}:
with lib; {
  normal.terminal.cicd = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; let
        system = stdenv.hostPlatform.system;
      in [
        # CICD
        just
        gnumake
        # Pipelight from flake
        inputs.pipelight.packages.${system}.default
        # Secret managment
        novops
      ];
      environment.sessionVariables = {
        # Cpu friendly cargo build jobs
        CARGO_BUILD_JOBS = "10";
      };
    };
  };
}
