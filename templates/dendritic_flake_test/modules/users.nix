{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  users.users."root" = {
    initialPassword = "root";
  };
  # users.users."anon" = {
  #   isNormalUser = true;
  #   initialPassword = "anon";
  # };
}
