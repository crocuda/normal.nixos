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
    rycee.url = "github:nix-community/nur-combined?dir=repos/rycee";
  };

  normal.browser.firefox = {
    nixos = {...}: {
      environment.systemPackages = with pkgs.nur.repos.rycee; [
        # https://sr.ht/~rycee/mozilla-addons-to-nix/
        mozilla-addons-to-nix
      ];
    };
    homeManager = {pkgs, ...}: {
      imports = [
        inputs.nur.modules.homeManager.default
      ];
      programs.firefox = {
        # native tridactyl support
        nativeMessagingHosts = [pkgs.tridactyl-native];

        profiles = let
          buildMozillaXpiAddon = inputs.rycee.lib.mozilla;
          # google-lighthouse =
          # Generated with:
          # ```sh
          # mozilla-addons-to-nix addons.json addons.nix
          # ```
          extensions = {
            packages = with pkgs.nur.repos.rycee.firefox-addons;
              [
                ublock-origin
                privacy-badger
                tridactyl
                keepassxc-browser
                darkreader
                # tranquility
                # rust-search-extension
              ]
              ++ [
                # google-lighthouse
                (import
                  ./_addons.nix)
              ];
            force = true;
          };
          defaultSettings = {
            # Enable extensions.
            "extensions.autoDisableScopes" = 0;
            "browser.tabs.firefox-view" = false;
            "browser.firefox-view.virtual-list.enabled" = false;
            "services.sync.prefs.sync.browser.firefox-view.feature-tour" = false;
          };
        in {
          default = {
            inherit extensions;
            settings = defaultSettings;
          };
          i2p = {
            inherit extensions;
            settings = defaultSettings;
          };
          normy = {
            settings = defaultSettings;
          };
        };
      };
    };
  };
}
