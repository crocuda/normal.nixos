{
  lib,
  inputs,
  ...
}:
with lib; {
  flake-file.inputs = {
    ## Browser
  };
  normal.browser.firefox = {
    homeManager = {...}: {
      programs.firefox = {
        profiles = let
          # Search engines
          search = {
            force = true;
            default = "SearxNG";
            order = [
              "SearxNG"
              "ddg"
            ];
            engines = {
              # Local search engine
              "SearxNG" = {
                urls = [
                  {template = "http://[::1]:8888/?q={searchTerms}";}
                  # {template = "http://127.0.0.1:8888/?q={searchTerms}";}
                ];
                # icon = "http://127.0.0.1:8888/static/themes/simple/img/favicon.svg";
                icon = "http://[::1]:8888/static/themes/simple/img/favicon.svg";
                updateInterval = 24 * 60 * 60 * 1000;
                definedAliases = ["@searx"];
              };

              # Nix engines
              "Nix Packages" = {
                urls = [
                  {
                    template = "https://search.nixos.org/packages";
                    params = [
                      {
                        name = "type";
                        value = "packages";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = ["@nixp"];
              };

              # Nixos resources
              "My NixOS" = {
                urls = [{template = "https://mynixos.com/search?q={searchTerms}";}];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = ["@nixs"];
              };

              "NixOS Wiki" = {
                urls = [{template = "https://nixos.wiki/index.php?search={searchTerms}";}];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = ["@nixw"];
              };

              # Rust Doc
              "Docs.rs" = {
                urls = [{template = "http://docs.rs/releases/search?query={searchTerms}";}];
                icon = "https://docs.rs/favicon.ico";
                updateInterval = 24 * 60 * 60 * 1000;
                definedAliases = ["@rust"];
              };

              # Common engines
              "wikipedia".metaData.alias = "@wiki";

              # Ebooks
              "Annas" = {
                urls = [
                  {template = "https://annas-archive.org/search?q={searchTerms}";}
                ];
                icon = "https://annas-archive.org/favicon-16x16.png";
                updateInterval = 24 * 60 * 60 * 1000;
                definedAliases = ["@annas"];
              };

              # Anime torrent
              "Nyaa" = {
                urls = [{template = "https://nyaa.si/?q={searchTerms}";}];
                icon = "https://nyaa.si/static/favicon.png";
                updateInterval = 24 * 60 * 60 * 1000;
                definedAliases = ["@nyaa"];
              };

              # Remove shity search engines
              "google".metaData.hidden = true;
              "amazondotcom-us".metaData.hidden = true;
              "amazondotnl".metaData.hidden = true;
              "bing".metaData.hidden = true;
              "ebay".metaData.hidden = true;
              "ecosia".metaData.hidden = true;
            };
          };
        in {
          default = {
            inherit search;
          };
          i2p = {
            inherit search;
          };
          normy = {
            inherit search;
          };
        };
      };
    };
  };
}
