{lib, ...}:
with lib; {
  normal.llm = {
    includes = [
      (den.batteries.unfree [
        # AI
        "lib.*"
        "cuda.*"
        # Nvidia
        "nvidia.*"
      ])
    ];
    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        # pkgs-unstable.ollama
        cudatoolkit
        freeglut
        # Python dependencies managment
        poetry

        # Add cuda binary cache
        cachix
      ];

      services.ollama = {
        package = pkgs.ollama-cuda;
        enable = true;
        host = "[::1]"; #ipv6
        port = 11434; #default
        # loadModels = ["mistral"];
        environmentVariables = {
          OLLAMA_LLM_LIBRARY = "cuda_v12";
        };
      };

      environment.sessionVariables = {
        # cli compat
        OLLAMA_API_KEY = "";
        OLLAMA_HOST = "http://[::1]:11434";
      };
      environment.variables = {
        OLLAMA_LLM_LIBRARY = "cuda_v12";
      };

      # Add cuda binary cache
      nix = {
        settings = {
          substituters = [
            "https://cuda-maintainers.cachix.org"
          ];
          trusted-public-keys = [
            "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
          ];
        };
      };
    };
    homeManager = {pkgs, ...}: {
      home.file = {
        ".config/mods/mods.yml".source = dotfiles/mods/mods.yml;
        ".config/fish/conf.d/mods.fish".text =
          # Ai shortcut
          ''
            function hey;
              mods -m mistral -f "$argv"
            end
            function ho;
              mods -m deepseek-r1 -f "$argv"
            end
          '';
      };
      home.packages = with pkgs; [
        # Ai cli from charmbracelet/ charm.sh
        mods
        glow
      ];
    };
  };
}
