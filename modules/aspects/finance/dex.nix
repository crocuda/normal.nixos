{...}: {
  normal.finance.dex = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        # Wallet
        # exodus

        ## Exchange
        # Dex
        # bisq-desktop
      ];
    };
  };
}
