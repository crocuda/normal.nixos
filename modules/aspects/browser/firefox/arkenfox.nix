{
  lib,
  inputs,
  ...
}:
with lib; {
  flake-file.inputs = {
    ## Browser
    # NUR - Nix User Repository
    nur.url = "github:nix-community/NUR";
    arkenfox.url = "github:dwarfmaster/arkenfox-nixos";
  };

  normal.browser.firefox = {
    nixos = {pkgs, ...}: {
      programs.firefox = {
        # package = pkgs.librewolf;
        enable = true;
        policies = {
          DisableFirefoxStudies = true;
          EnableTrackingProtection = {
            Value = true;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
          };
          # Disable pasword manager
          PasswordManagerEnabled = false;
          OfferToSaveLoginsDefault = false;

          DisableTelemetry = true;
          DisablePocket = true;
          DisableFirefoxAccounts = true;
          DisableAccounts = true;
          DisableFirefoxScreenshots = true;
          OverrideFirstRunPage = "";
          OverridePostUpdatePage = "";
          DontCheckDefaultBrowser = true;
          DisplayMenuBar = "default-off";
          SearchBar = "unified";
          NoDefaultBookmarks = true;
          DisplayBookmarksToolbar = "never";
          Preferences = let
            lock-false = {
              Value = false;
              Status = "locked";
            };
            lock-true = {
              Value = true;
              Status = "locked";
            };
            lock-empty-string = {
              Value = "";
              Status = "locked";
            };
          in {
            "toolkit.legacyUserProfileCustomizations.stylesheets" = lock-true;

            # Remove poluting defaults
            "extensions.pocket.enabled" = lock-false;

            # Remove default top sites
            "browser.topsites.contile.enabled" = lock-false;
            "browser.urlbar.suggest.topsites" = lock-false;

            # Remove sponsored sites
            "browser.newtabpage.pinned" = lock-empty-string;
            "browser.newtabpage.activity-stream.showSponsored" = lock-false;
            "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
            "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;

            # Remove firefox shiny buttons
            "browser.tabs.firefox-view" = false;
            "browser.tabs.firefox-view-next" = false;
            # Style
            "browser.compactmode.show" = lock-true;
            "browser.uidensity" = {
              Value = 1;
              Status = "locked";
            };
            # Fonts - make web pages follow system font
            "browser.display.use_document_fonts" = {
              Value = 0;
              Status = "locked";
            };
          };
        };
      };
    };
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
