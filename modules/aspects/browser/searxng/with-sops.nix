{inputs, ...}: {
  flake-file.inputs = {
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  normal.browser.searxng.sops = {
    nixos = {
      pkgs,
      config,
      lib,
      ...
    }: {
      imports = [
        # Secrets
        inputs.sops-nix.nixosModules.sops
      ];
      ## WARNING: setting secret_key here might expose it to the nix cache
      # see below for the sops or environment file instructions to prevent this
      sops.secrets."searx" = {
        owner = "root";
        group = "searx";
        mode = "0440";
        path = "/var/lib/searx/secret";
      };
      services.searx.environmentFile = "/var/lib/searx/secret";
      services.searx.server.secret_key = config.sops.secrets.searx.path;
    };
  };
}
