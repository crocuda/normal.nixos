-- Checkout https://github.com/NvChad/NvChad for up to date plugin settings
--
-- Nvchad plugin config

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

return {
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "nvchad.autocmds"
    end,
  },
}
