-- Checkout https://github.com/NvChad/NvChad for up to date plugin settings

return {
  -- File managing , picker etc
  {
    "stevearc/oil.nvim",
    lazy = false,
    ---@module 'oil'
    -- ---@type oil.SetupOpts
    config = function()
      return require("oil").setup(require("configs.oil").options)
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
  },
  {
    "avm99963/vim-jjdescription",
    lazy = false,
  },
  {
    "windwp/nvim-autopairs",
    lazy = false,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    lazy = false,
  },

  -- Smooth navigation experience
  --
  {
    "psliwka/vim-smoothie",
    lazy = false,
  },
  {
    "nvim-focus/focus.nvim",
    lazy = false,
    opts = require("configs.focus").options,
    config = function()
      return require("focus").setup(require("configs.focus").options)
    end,
  },
}
