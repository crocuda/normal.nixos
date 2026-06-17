{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  inputs,
  ...
}:
with lib; let
  nvrh-latest = pkgs.callPackage ./nvrh.latest.nix {};
in
  mkIf (config.normal.editors.neovim.enable
    || config.normal.editors.nvchad.enable
    || config.normal.editors.nvchad-ide.enable)
  {
    # Ensure irectory for neovim servers RPC sockets.
    systemd.tmpfiles.rules = [
      "d /var/lib/nvim/servers 774 root users - -"
    ];

    # Set default editor
    programs = {
      nano = {
        enable = false;
      };
      neovim = {
        defaultEditor = true;
      };
    };

    # Add essential developer packages
    environment.systemPackages = with pkgs; [
      nvrh-latest
      # Minimal text editor
      vim
      # neovim as IDE
      neovim
    ];
  }
