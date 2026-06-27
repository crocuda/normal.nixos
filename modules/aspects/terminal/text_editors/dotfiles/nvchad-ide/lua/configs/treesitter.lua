local M = {}
-- Enable tree-sitter when entering a buffer

-- nvim-dbee fix
M.enable_tree_sitter = function(data)
  vim.cmd "TSEnable highlight"
end
-- vim.api.nvim_create_autocmd("BufNewFile", { callback = M.enable_tree_sitter })
-- vim.api.nvim_create_autocmd("BufReadPre", { callback = M.enable_tree_sitter })
-- vim.api.nvim_create_autocmd("FileReadPre", { callback = M.enable_tree_sitter })
-- vim.api.nvim_create_autocmd("FilterReadPre", { callback = M.enable_tree_sitter })
--
M.init = function()

  vim.api.nvim_create_autocmd('FileType', {
    pattern = { '<filetype>' },
    callback = function() vim.treesitter.start() end,
  })

  -- vim.api.nvim_create_autocmd('FileType', {
  --   callback = function()
  --     -- Enable treesitter highlighting and disable regex syntax
  --     pcall(vim.treesitter.start)
  --     -- Enable treesitter-based indentation
  --     vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  --   end,
  -- })
  --
--   local alreadyInstalled = require('nvim-treesitter.config').get_installed()
--   local parsersToInstall = vim.iter(
--         M.options.ensure_installed
--       )
--       :filter(function(parser)
--         return not vim.tbl_contains(alreadyInstalled, parser)
--       end)
--       :totable()
--   require('nvim-treesitter').install(parsersToInstall)
-- end

M.install = {

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
    -- "markdown_inline",

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
  },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
  },
}

require("nvim-treesitter.configs").setup(M.options)

return M
