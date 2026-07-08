{normal, ...}: {
  normal.bluetooth = {
    ## Add Users to admin groups.
    policies.to-host = {user, ...}: {
      nixos = {...}: {
        users.groups = {
          bluetooth.members = [];
        };
        users.users.${user.userName} = {
          extraGroups = [
            "bluetooth"
          ];
        };
      };
    };
    includes = [
      normal.bluetooth.policies.to-host
    ];
    nixos = {
      pkgs,
      user,
      ...
    }: {
      ##########################
      ## Bluetooth
      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
          General = {
            Enable = "Source,Sink,Media,Socket";
            ControllerMode = "dual"; # "bre/rd", "le", or "dual"
            FastConnectable = true;
            Experimental = true;
          };
          Policy = {
            AutoEnable = true;
          };
        };
        input = {
          General = {
            ClassicBondedOnly = false;
            UserspaceHID = true;
          };
        };
        network = {
          General = {
            DisableSecurity = true;
          };
        };
      };
      services.blueman = {
        enable = true;
      };
      # systemd.tmpfiles.rules = [
      #   "d /var/lib/bluetooth 700 root root - -"
      # ];
    };
  };
}
