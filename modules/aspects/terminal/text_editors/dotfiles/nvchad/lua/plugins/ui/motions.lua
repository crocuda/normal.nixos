return {
  {
    "windwp/nvim-autopairs",
    lazy = false,
  },
  { "echasnovski/mini.ai", version = false, lazy = false },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      -- colemak-dh
      labels = "arstgoienmqwfpbyuljxcdvzhk",
      search = {
        forward = false,
        backward = false,
        multi_window = false,
        continue = false,
        jump_labels = true,
      },
      autojump = true,
      modes = {
        search = {
          enabled = true,
        },
        char = {
          enabled = false,
        },
      },
    },
    keys = {
      -- Disable defaults
      { "s", mode = { "n", "x", "o" }, false },
      { "S", mode = { "n", "o", "x" }, false },
      {
        "f",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash jump to pattern",
      },
    },
  },
}
