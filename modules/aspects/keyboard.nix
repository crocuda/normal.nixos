{...}: {
  normal.keybord = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        ## Keyboard configuration utils
        via
      ];
    };
  };
}
