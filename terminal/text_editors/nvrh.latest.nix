{
  pkgs ? import <nixpkgs> {},
  lib,
  ...
}:
with lib;
with pkgs;
  buildGoModule rec {
    pname = "nvrh";
    version = "v0.9.0";

    src = fetchFromGitHub {
      owner = "mikew";
      repo = "nvrh";
      # tag = "v${version}";
      rev = "main";
      # hash = lib.fakeHash;
      hash = "sha256-aIL+ct5qd54UhETynHkVsr1D25nokOGXICzoHq2b9so=";
    };
    # vendorHash = lib.fakeHash;
    vendorHash = "sha256-Pm207AkPPC/5mNqlpq3X5IZcTaNNqFSh98WlCj/Vq/g=";
    preBuild = ''
      cp package.json src/
    '';
    ldflags = [
      "-s"
      "-w"
    ];
    postInstall = ''
      mv $out/bin/src $out/bin/nvrh
    '';
  }
