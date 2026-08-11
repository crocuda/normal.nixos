{
  lib,
  inputs,
  ...
}:
with lib; {
  flake-file.inputs = {
  };

  normal.browser.firefox = {
    homeManager = {pkgs, ...}: {
      home.file = {
        # Desktop entry for firefox_i2p
        ".local/share/applications/firefox_i2p.desktop".source = dotfiles/firefox_i2p.desktop;
        ".local/share/applications/firefox_normy.desktop".source = dotfiles/firefox_normy.desktop;
        ".config/tridactyl".source = dotfiles/tridactyl;
      };

      programs.firefox = {
        enable = true;
        # package = pkgs.librewolf;
        languagePacks = ["en-GB" "fr"];

        # native tridactyl support
        nativeMessagingHosts = [pkgs.tridactyl-native];

        profiles = {
          default = {
            userChrome = builtins.readFile dotfiles/userChrome.css;
            isDefault = true;
            id = 0;
            settings = {} // defaultSettings;
          };
          i2p = {
            userChrome = builtins.readFile dotfiles/userChrome_alt.css;
            isDefault = false;
            id = 1;
            settings =
              {
                "dom.security.https_only_mode" = lib.mkForce false;
                "media.peerconnection.ice.proxy_only" = true;
                "network.proxy.type" = 1;
                "network.proxy.http" = "127.0.0.1";
                "network.proxy.http_port" = 4444;
                "network.proxy.ssl" = "127.0.0.1";
                "network.proxy.ssl_port" = 4444;
                # Enable extensions.
                "extensions.autoDisableScopes" = 0;
              }
          };
          normy = {
            userChrome = builtins.readFile dotfiles/userChrome_normy.css;
            isDefault = false;
            id = 2;
          };
          open = {
            userChrome = builtins.readFile dotfiles/userChrome_normy.css;
            id = 3;
          };
        };
      };
    };
  };
}
