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
    nixos = {pkgs, ...}: {
      imports = [
        inputs.nur.modules.nixos.default
      ];
      environment.systemPackages = with pkgs.nur.repos.rycee; [
        # https://sr.ht/~rycee/mozilla-addons-to-nix/
        mozilla-addons-to-nix
      ];
    };
    homeManager = {
      pkgs,
      lib,
      ...
    }: {
      imports = [
        inputs.nur.modules.homeManager.default
      ];
      programs.firefox = {
        # native tridactyl support
        nativeMessagingHosts = [pkgs.tridactyl-native];

        profiles = let
          rycee_lib = inputs.rycee.lib {inherit lib;};
          libMozilla = rycee_lib.mozilla;
          buildMozillaXpiAddon = libMozilla.mkBuildMozillaXpiAddon {inherit (pkgs) fetchurl stdenv;};

          # Generated with:
          # ```sh
          # mozilla-addons-to-nix addons.json addons.nix
          # ```
          "google-lighthouse" = buildMozillaXpiAddon {
            pname = "google-lighthouse";
            version = "100.0.0.3";
            addonId = "{cf3dba12-a848-4f68-8e2d-f9fadc0721de}";
            url = "https://addons.mozilla.org/firefox/downloads/file/4148676/google_lighthouse-100.0.0.3.xpi";
            sha256 = "49cb8c94d536e1f49b76a3e75e8cd0c361961061da53039abbc5db755944afb9";
            meta = with lib; {
              homepage = "https://github.com/GoogleChrome/lighthouse";
              description = "Lighthouse is an open-source, automated tool for improving the performance, quality, and correctness of your web apps.";
              mozPermissions = ["activeTab" "storage"];
              platforms = platforms.all;
            };
          };
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
                google-lighthouse
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
