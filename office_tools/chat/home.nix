{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
  mkIf config.normal.chat.enable {
    home.packages = with pkgs; [
      # Mail client
      thunderbird

      # Messaging apps
      # session-desktop
      signal-desktop
      # element-desktop
      # telegram-desktop

      # Bottom tier apps
      # discord

      # A terminal based chat application plugable with
      # ircd and darkirc
      # weechat

      # Social network
      # tuba
    ];
  }
