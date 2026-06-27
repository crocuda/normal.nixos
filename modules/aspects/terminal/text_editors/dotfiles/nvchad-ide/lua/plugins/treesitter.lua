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
    config = function(_, opts)
      require "configs.treesitter-textobjects"
    end,
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

      require "configs.treesitter"
      require("nvim-treesitter").install {

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
