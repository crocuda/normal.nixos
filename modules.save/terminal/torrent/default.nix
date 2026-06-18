{lib, ...}:
with lib; {
  flake-file.inputs = {
    # Torrent
    rustmission.url = "github:intuis/rustmission";
  };

  normal.torrent = {
    nixos = {pkgs, ...}: {
      ################################
      ### Torrent
      services.transmission = {
        enable = true;
        package = pkgs.transmission_4;
      };
    };
    homeManager = {pkgs, ...}: {
      home.packages = with pkgs; [
        # Torrenting
        # inputs.rustmission.packages.${system}.default
        rustmission
      ];
      home.file = {
        ".config/rustmission/config.toml".source = dotfiles/rustmission/config.toml;
      };
    };
  };
}
