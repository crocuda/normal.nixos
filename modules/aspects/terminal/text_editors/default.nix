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
        ".config/fish/conf.d/nvim.fish".text = ''
          alias nv='NVIM_APPNAME=nvim nvim'
        '';
      };
      home.packages = with pkgs; [
        neovim
      ];
    };
  };
  normal.nvchad = {
    includes = [
      normal.nvim
      normal.nvim.deref
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
        # ".config/nvchad/init.lua".source = dotfiles/nvchad/init.lua;
        ".config/nvchad/init.lua".text = ''
          require "config.lazy"
        '';
        ".config/fish/conf.d/nvim.fish".text = ''
          alias nvi='NVIM_APPNAME=nvchad nvim'
        '';
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
      # normal.nvchad-ide._
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
        ".config/fish/conf.d/zellij.fish".text = ''
          function ze;
            zellij attach $argv --force-run-commands;
          end
          export ze
        '';

        # NvChadIde
        ".config/nvchad-ide/lua".source = dotfiles/nvchad/lua;
        # ".config/nvchad/init.lua".source = dotfiles/nvchad/init.lua;
        ".config/nvchad-ide/init.lua".text = ''
          require "config.lazy-ide"
        '';

        ".config/fish/conf.d/nvim.fish".text = ''
          alias nvid='neovide'
        '';

        # Lock plugin versions
        # :Lazy sync on first boot
        # ".config/nvim/lazy-lock.json".source = dotfiles/nvchad/lazy-lock.json;
      };
      home.packages = with pkgs; [
        ### formatters
        alejandra
        prettierd
        prettier
        sqruff
        black
        ruff
        stylua

        ### lsp
        nil
        lua-language-server
        sqls
        zls
        gopls
        typescript-language-server
        # astro-language-server
        vue-language-server

        ## markup
        yaml-language-server
        marksman
        taplo
        tinymist

        openscad-lsp
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
  normal.nvchad-ide.astro = {
    homeManager = {
      pkgs,
      config,
      ...
    }: {
      programs.neovim = {
        initLua = ''
          vim.lsp.config['astro'] = {
            init_options = {
              typescript = {
                tsdk = ${pkgs.typescript}/lib/node_modules/typescript/lib,
              },
            },
          }

          vim.lsp.enable('astro')
        '';
      };
    };
  };
}
