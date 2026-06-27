return {
  -- LSP
  --
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig.default"
    end,
    lazy = false,
  },
}
