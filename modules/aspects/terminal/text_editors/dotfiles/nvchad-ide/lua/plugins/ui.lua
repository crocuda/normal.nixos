-- Checkout https://github.com/NvChad/NvChad for up to date plugin settings

return {
  {
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
    "stevearc/oil.nvim",
    lazy = false,
    ---@module 'oil'
    -- ---@type oil.SetupOpts
    config = function()
      return require("oil").setup(require("configs.oil").options)
    end,
  },
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

  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
  },
  {
    "avm99963/vim-jjdescription",
    lazy = false,
  },
  -- Session manager
  -- https://github.com/NvChad/NvChad/issues/646
  {
    "rmagatti/auto-session",
    ---@module "auto-session"
    cmd = { "SaveSession", "RestoreSession" },
    config = function()
      -- Autosession compat
      -- vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
      vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winpos,localoptions"

      require("auto-session").setup {
        log_level = "warn",
        -- auto_session_enable_last_session = true,
        root_dir = vim.fn.stdpath "data" .. "/sessions",
        -- auto_session_enabled = true,
        -- auto_save_enabled = true,
        -- auto_restore_enabled = true,
        auto_session_suppress_dirs = nil,
        pre_save_cmds = { "tabdo NvimTreeClose" },
        post_restore_cmds = { "tabdo NvimTreeRefresh" },

        -- Filtering
        close_unsupported_windwows = true,
      }
    end,
    lazy = false,
  },

  -- Smooth navigation experience
  {
    "psliwka/vim-smoothie",
    lazy = false,
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
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    opts = {
      cursor_follows_swapped_bufs = true,
    },
  },
  {
    "nvim-focus/focus.nvim",
    lazy = false,
    -- event = "VeryLazy",
    opts = require("configs.focus").options,
    config = function()
      -- Fix warning
      -- vim.opt.winwidth = 35

      local ignore_filetypes = {
        "NvimTree",
        "NvimTree_1",
        "DiffviewFiles",
        -- "toggleterm",
      }
      local ignore_buftypes = {
        "popup",
        "nofile",
        "terminal",
        -- "prompt",
      }

      local augroup = vim.api.nvim_create_augroup("FocusDisable", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter", "FileType", "VimEnter" }, {
        group = augroup,
        callback = function(_)
          if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
            vim.o.winwidth = 35
            vim.w.focus_disable = true
          else
            vim.o.winwidth = 60
            vim.w.focus_disable = false
          end
        end,
        desc = "Disable focus autoresize for BufType",
      })

      vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter", "FileType", "VimEnter" }, {
        group = augroup,
        callback = function(_)
          if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
            vim.o.winwidth = 35
            vim.b.focus_disable = true
          else
            vim.o.winwidth = 60
            vim.b.focus_disable = false
          end
        end,
        desc = "Disable focus autoresize for FileType",
      })

      vim.api.nvim_create_autocmd({ "VimResized" }, {
        group = augroup,
        callback = function(_)
          if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
          --
          else
            vim.cmd "wincmd ="
          end
        end,
        desc = "Resize panes/splits on window resize for BufType",
      })

      vim.api.nvim_create_autocmd({ "VimResized" }, {
        group = augroup,
        callback = function(_)
          if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
          --
          else
            vim.cmd "wincmd ="
          end
        end,
        desc = "Resize panes/splits on window resize for FileType",
      })
      return require("focus").setup {
        enable = true,
        ui = {
          -- Things to display in the focussed window only
          number = false,
          signcolumn = true,
        },
        autoresize = {
          enable = false,
          width = 90,
          height = 30,
          -- ugli but works
          -- minwidth = 60,
          -- minwidth = 35,
          height_quickfix = 10,
        },
      }
    end,
  },
}
