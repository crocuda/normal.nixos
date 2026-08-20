{
  lib,
  inputs,
  ...
}:
with lib; {
  flake-file.inputs = {
    ## Browser
    arkenfox.url = "github:dwarfmaster/arkenfox-nixos";
  };

  normal.browser.firefox = {
    homeManager = {pkgs, ...}: {
      imports = [
        inputs.arkenfox.homeModules.default
      ];
      programs.firefox = {
        ## Enable arkenfox user.js
        arkenfox = {
          enable = true;
          version = "140.0";
        };
        profiles = let
          arkenfox = {
            enable = true;
            # Get every susbsection number
            # jq 'keys' arkenfox-nixos/autogen/122.0.json
            "0000".enable = true;
            "0100".enable = true;
            "0200".enable = true;
            "0300".enable = true;
            "0400".enable = true;
            "0600".enable = true;
            "0700".enable = true;
            "0800".enable = true;
            "0900".enable = true;
            "1000".enable = true;
            "1200".enable = true;
            "1600".enable = true;
            "1700".enable = true;
            "2000".enable = true;
            "2400".enable = true;
            "2600".enable = true;
            "2700".enable = true;
            "2800".enable = true;
            "4000".enable = true;
            "4500".enable = true;
            "5000".enable = true;
            "5500".enable = true;
            "6000".enable = true;
            "7000".enable = true;
            "8000".enable = true;
            "9000".enable = true;
          };
        in {
          default = {
            inherit arkenfox;
          };
          i2p = {
            inherit arkenfox;
          };
        };
      };
    };
  };
}
