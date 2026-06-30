{...}: {
  normal.neofetch = {
    homeManager = {
      lib,
      pkgs,
      config,
      ...
    }: {
      home.file = {
        # ".config/fastfetch/config.json".source = dotfiles/fastfetch/config.json;
      };
      # Terminal
      environment.systemPackages = with pkgs; [
        fastfetch
      ];
    };
  };
}
