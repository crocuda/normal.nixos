return {
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
