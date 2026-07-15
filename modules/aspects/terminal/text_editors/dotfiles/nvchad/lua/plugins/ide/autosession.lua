-- Autosession compat
-- vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

return {
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

        -- Filtering
        close_unsupported_windwows = true,

        -- If usiging NvimTree
        --
        -- pre_save_cmds = { "tabdo NvimTreeClose" },
        -- post_restore_cmds = { "tabdo NvimTreeRefresh" },
      }
    end,
    lazy = false,
  },
}
