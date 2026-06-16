{
  pkgs ? import <nixpkgs> {},
  lib,
  ...
}:
with lib;
with pkgs;
  buildGoModule rec {
    pname = "nvrh";
    version = "0.9.0";

    src = fetchFromGitHub {
      owner = "mikew";
      repo = "nvrh";
      tag = version;
      sha256 = lib.fakeSha256;
      # sha256 = "sha256-t43xXUzXoj0Fxrt/BZaBP1fua2W8HPd1x9bsTV0uUD4=";
    };
  }
