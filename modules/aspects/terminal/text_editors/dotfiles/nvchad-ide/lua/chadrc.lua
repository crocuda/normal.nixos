-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

-- @types ChadrcConfig
local M = {}

M.base46 = {
  theme = "doomchad",
  hl_add = {
    ["BuffLineFileTitle"] = { bg = "black2", fg = "green" },
    ["FileCursor"] = { bg = "grey", fg = "green" },
  },
  hl_override = {
    ["St_LspMsg"] = { bg = "black2" },
    ["St_LspInfo"] = { bg = "black2" },
    ["St_LspHints"] = { bg = "black2" },
    ["St_Lsp"] = { bg = "black2" },
    ["St_file_sep"] = { bg = "black2" },
    ["St_gitIcons"] = { bg = "black2" },
  },
}

M.ui = {
  cmp = {
    icons = false,
  },
  tabufline = {
    enabled = true,
    lazyload = false,
    order = { "file_rel_path" },
    modules = {
      -- Display active buffer filepath relative to project root.
      file_rel_path = function()
        local cwd = vim.loop.cwd()
        local path = vim.api.nvim_buf_get_name(0)
        local subpath = string.gsub(path, cwd, "")
        return "%#BuffLineFileTitle#" .. subpath
      end,
    },
  },
  statusline = {
    theme = "default",
    separator_style = "default",
    order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cursor" },
    modules = {
      cursor = function()
        local lines = vim.fn.line "$"
        return "%#FileCursor#" .. " " .. lines .. " l - " .. "%p %% "
      end,
    },
  },
}

M.term = {
  base46_colors = true,
}

return M
