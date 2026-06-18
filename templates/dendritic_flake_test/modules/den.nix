{
  inputs,
  den,
  normal,
  lib,
  ...
}: {
  imports = [
    inputs.den.flakeModule
    # inputs.normal.denful.normal
    (inputs.den.namespace "normal" inputs.normal)
    # inputs.normal.flakeModule
  ];

  den.schema.user.classes = lib.mkDefault ["homeManager"];

  den.hosts.x86_64-linux.default.users.anon = {};

  den.aspects.default = {
    includes = [
      den.batteries.hostname
      normal.android
    ];
    nixos = {pkgs, ...}: {
      environment.systemPackages = [
        pkgs.hello
      ];
    };
  };

  den.aspects.anon = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user
    ];
    # nixos = {user, ...}: {
    #   users.users."${user.userName}" = {
    #     isNormalUser = true;
    #     initialPassword = "anon";
    #   };
    # };
    homeManager = {pkgs, ...}: {
      home.packages = [pkgs.vim];
    };
  };
}
