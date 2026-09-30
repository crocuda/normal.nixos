{den, ...}: {
  normal.keyboard = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        ## Keyboard configuration utils
        via
      ];
    };
    includes = [
      (den.batteries.unfree [
        "via"
      ])
    ];
  };
}
