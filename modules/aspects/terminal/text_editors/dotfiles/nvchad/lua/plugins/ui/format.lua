return {
  {
    "lukas-reineke/indent-blankline.nvim",
    lazy = false,
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require("conform").setup {
        -- Add formatters that are not handled by conform.nvim
        formatters = {
          hclfmt = {
            command = "hclfmt",
          },
          caddy = {
            command = "caddy",
            args = { "fmt", "-" },
            stdin = true,
          },
        },
        -- Prettier recommandations:
        -- Install latest prettier outside of nix
        -- with: bun install -g prettier
        -- then add sepecfic lang support:
        --  - bun add -g @prettier/plugin-pug
        formatters_by_ft = {
          lua = { "stylua" },

          markdown = { "prettier", "prettierd" },

          css = { "prettier", "prettierd" },
          pug = { "prettier", "prettierd" },
          html = { "prettier", "prettierd" },
          javascript = { "prettier", "prettierd" },
          typescript = { "prettier", "prettierd" },

          astro = { "prettier", "prettierd" },

          typescriptreact = { "prettier", "prettierd" },
          svelte = { "prettier", "prettierd" },
          graphql = { "prettier", "prettierd" },

          toml = { "taplo" },
          yaml = { "prettier", "prettierd" },
          json = { "prettier", "prettierd" },

          python = { "black" },

          -- rust = { "rust-fmt" },
          go = { "prettier", "prettierd" },
          nix = { "alejandra" },
          zig = { "zigfmt" },
          hcl = { "hclfmt" },
          sql = { "sqruff" },

          proto = { "buf" },
          caddy = { "caddy" },
        },

        format_on_save = {
          -- These options will be passed to conform.format()
          timeout_ms = 500,
          lsp_fallback = true,
        },
      }
    end,
    lazy = false,
  },
  {
    "numToStr/Comment.nvim",
    lazy = true,
    config = function()
      -- require("Comment").setup()
      local ft = require "Comment.ft"
      ft.set("zone", { ";%s", ";;%s" })
      ft.set("rcl", { "//%s", "//%s" })
      ft.set("kdl", { "//%s", "//%s" })
      ft.set("caddy", { "#%s", "#%s" })
    end,
  },
  {
    "echasnovski/mini.comment",
    lazy = false,
    config = function()
      require("mini.comment").setup {
        options = {
          custom_commentstring = function()
            return vim.bo.commentstring
          end,
        },
        mappings = {
          comment = "<leader>/",
          comment_line = "<leader>/",
          comment_visual = "<leader>/",
          textobject = "<leader>/",
        },
      }
    end,
  },
}
