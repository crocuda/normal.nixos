-- NVTelescope: Ripgrep
-- fix: ignore hidden files
vim.o.grepprg = "rg --vimgrep --no-hidden --no-heading"

return {
  -- File managing , picker etc
  -- {
  --   "nvim-tree/nvim-tree.lua",
  --   cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeRefresh" },
  --   opts = function()
  --     return require("configs.nvimtree").options
  --   end,
  --   config = function(_, opts)
  --     require("nvim-tree").setup(opts)
  --   end,
  -- },
  {
    -- Bulk find and replace utility
    "MagicDuck/grug-far.nvim",
    lazy = false,
    -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
    -- additional lazy config to defer loading is not really needed...
    config = function()
      -- optional setup call to override plugin options
      -- alternatively you can set options with vim.g.grug_far = { ... }
      require("grug-far").setup {
        -- options, see Configuration section below
        -- there are no required options atm
      }
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },

  ------------------------------
  -- NvChad Ui / NvUi
  "nvim-lua/plenary.nvim",
  { "nvim-tree/nvim-web-devicons", lazy = true },

  {
    "nvchad/ui",
    config = function()
      require "nvchad"
    end,
  },
  {
    "nvchad/base46",
    lazy = true,
    build = function()
      require("base46").load_all_highlights()
    end,
  },

  -- Smooth navigation experience
  {
    "psliwka/vim-smoothie",
    lazy = false,
  },
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    opts = {
      cursor_follows_swapped_bufs = true,
    },
  },
  {
    "echasnovski/mini.animate",
    lazy = false,
    config = function()
      local animate = require "mini.animate"
      local is_many_wins = function(sizes_from, sizes_to)
        return vim.tbl_count(sizes_from) >= 2
      end
      require("mini.animate").setup {
        open = {
          enable = false,
        },
        close = {
          enable = false,
        },
        scroll = {
          enable = false,
        },
        cursor = {
          enable = false,
        },
        resize = {
          enable = true,
          timing = animate.gen_timing.linear { easing = "out", duration = 14, unit = "total" },
          subresize = animate.gen_subresize.equal { predicate = is_many_wins },
        },
      }
    end,
  },
  {
    "eero-lehtinen/oklch-color-picker.nvim",
    event = "VeryLazy",
    version = "*",
    ---@type oklch.Opts
    opts = {},
  },
  -- {
  --   "brenoprata10/nvim-highlight-colors",
  --   lazy = true,
  --   config = function()
  --     vim.opt.termguicolors = true
  --     require("nvim-highlight-colors").setup {
  --       ---Highlight hex colors, e.g. '#FFFFFF'
  --       enable_hex = true,
  --       ---Highlight short hex colors e.g. '#fff'
  --       enable_short_hex = true,
  --       ---Highlight rgb colors, e.g. 'rgb(0 0 0)'
  --       enable_rgb = true,
  --       ---Highlight hsl colors, e.g. 'hsl(150deg 30% 40%)'
  --       enable_hsl = true,
  --       ---Highlight CSS variables, e.g. 'var(--testing-color)'
  --       enable_var_usage = true,
  --       ---Highlight named colors, e.g. 'green'
  --       enable_named_colors = true,
  --       ---Highlight tailwind colors, e.g. 'bg-blue-500'
  --       enable_tailwind = false,
  --     }
  --   end,
  -- },
  -- {
  --   "0xm4n/resize.nvim",
  --   lazy = false,
  -- },
}
