{
  config,
  cfg,
  pkgs,
  lib,
  ...
}:
with lib;
  mkIf (config.normal.editors.neovim.enable
    || config.normal.editors.nvchad.enable
    || config.normal.editors.nvchad-ide.enable)
  {
  }
