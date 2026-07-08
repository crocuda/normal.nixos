return {
  -- Deprecate usage in favor of nix.
  -- {
  -- 	"williamboman/mason.nvim",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"lua-language-server", "stylua",
  -- 			"html-lsp", "css-lsp" , "prettier"
  -- 		},
  -- 	},
  -- },
  --
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    config = function(_, opts) end,
    branch = "main",
    lazy = false,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "syntax")
      dofile(vim.g.base46_cache .. "treesitter")

      -- Enable tree-sitter when filetype detected
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "<filetype>" },
        callback = function()
          vim.treesitter.start()
        end,
      })

      -- Add custom language: DNS Zone.
      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = function()
          -- require("nvim-treesitter.parsers").dns_zone = {
          require("nvim-treesitter.parsers").bindzone = {
            install_info = {
              url = "https://github.com/goulinkh/tree-sitter-dns-zone.git",
              branch = "main",
              queries = "queries",
            },
          }
        end,
      })
      -- vim.treesitter.language.register("dns_zone", { "bindzone" })

      -- require "configs.treesitter"
      require("nvim-treesitter").install {
        --dns
        -- "bindzone",
        -- "dns_zone",

        -- usual
        "vim",
        "vimdoc",
        "bash",
        "lua",
        "nix",

        --database
        "sql",

        -- markup
        "toml",
        "yaml",
        "jq",
        "xml",
        "csv",
        "markdown",
        "markdown_inline",

        -- builder
        "go",
        "zig",
        "rust",
        "c",
        "r",
        "rnoweb",

        -- web
        "vue",
        "javascript",
        "typescript",
        "css",
        "scss",
        "pug",
        "html",

        "caddy",

        "yuck",
      }
    end,
  },
}
