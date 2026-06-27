{
  normal,
  lib,
  ...
}: {
  normal.nvim = {
    nixos = {pkgs, ...}: {
      # Add essential developer packages
      environment.systemPackages = with pkgs; [
        # Minimal text editor
        vim
        # neovim as IDE
        neovim
      ];
      # Set default editor
      programs = {
        nano = {
          enable = false;
        };
        neovim = {
          defaultEditor = true;
        };
      };
      # Ensure directory for neovim servers RPC sockets.
      systemd.tmpfiles.rules = [
        "d /var/lib/nvim/servers 774 root users - -"
        # Less
      ];
    };
    homeManager = {
      pkgs,
      lib,
      ...
    }: {
      home.sessionVariables = with lib; {
        NVIM_APPNAME = mkDefault "nvim";
        EDITOR = mkDefault "nvim";
        MANPAGER = mkDefault "nvim +Man!";
      };
      home.file = {
        # Vim colemak conf
        ".vimrc".source = dotfiles/.vimrc;
        # Neovim
        ".config/nvim/lua".source = dotfiles/nvim/lua;
        ".config/nvim/init.lua".source = dotfiles/nvim/init.lua;
        ".lesskey".source = dotfiles/.lesskey;
      };
      home.packages = with pkgs; [
        neovim
      ];
    };
  };
  normal.nvchad = {
    includes = [
      normal.nvim
    ];
    homeManager = {
      pkgs,
      lib,
      ...
    }: {
      home.sessionVariables = with lib; {
        NVIM_APPNAME = mkOverride 500 "nvchad";
        EDITOR = mkOverride 500 "nvim -u ~/.config/nvchad/init.lua";
        MANPAGER = mkOverride 500 "nvim -u ~/.config/nvchad/init.lua -c 'Man!' -o -";
      };
      home.file = {
        # NvChad
        ".config/nvchad/lua".source = dotfiles/nvchad/lua;
        ".config/nvchad/init.lua".source = dotfiles/nvchad/init.lua;
      };
      home.packages = with pkgs; [
        neovim
        ## Lsp lint/formatting tools
        tree-sitter
      ];
    };
  };
  normal.nvchad-ide = {
    includes = [
      normal.nvchad
      normal.aspects.fonts
    ];
    homeManager = {
      pkgs,
      config,
      ...
    }: {
      home.sessionVariables = with lib; {
        NVIM_APPNAME = mkOverride 100 "nvchad-ide";
      };

      home.file = {
        # Terminal multiplexer
        ".config/zellij".source = dotfiles/zellij;

        # NvChadIde
        ".config/nvchad-ide/lua".source = dotfiles/nvchad-ide/lua;
        ".config/nvchad-ide/init.lua".source = dotfiles/nvchad-ide/init.lua;

        # Lock plugin versions
        # :Lazy sync on first boot
        # ".config/nvim/lazy-lock.json".source = dotfiles/nvchad/lazy-lock.json;
      };
      home.packages = with pkgs; [
        # formaters
        alejandra
        prettierd
        sqruff
        black
        ruff
        stylua
        # lsp
        nil
        lua-language-server
        ltex-ls
        marksman
        openscad-lsp
        sqls
        taplo
        tinymist
        zls
        gopls
      ];

      programs.neovide = {
        enable = true;
        settings = {
          frame = "full";
          fork = true;
          maximized = false;
          vsync = true;
          wls = false;
          srgb = false;
          font = {
            normal = [
              "JetBrainsMono Nerd Font Mono"
              "NotoSansM Nerd Font Mono"
              "Noto Sans Mono CJK JP"
              "Noto Color Emoji"
            ];
            size = config.normal.font.size - 0.2;
          };
        };
      };
    };
  };
}
