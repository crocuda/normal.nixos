-- Nix unit tests
-- Configure vim-test to use Lix-unit on .nix files
local M = {}
-- Returns true if the given file belongs to your test runner
-- test#mylanguage#myrunner#test_file(file)
M.test_file = function(file)
  -- local filetype = vim.filetype.match { filename = file }
  -- return filetype == "nix"
  return true
end

-- Returns test runner's arguments which will run the current file and/or line
-- test#mylanguage#myrunner#build_position(type, position)
M.build_position = function(type, position) end

-- Returns processed args (if you need to do any processing)
-- test#mylanguage#myrunner#build_args(args)
M.build_args = function(args) end

--Returns the executable of your test runner
-- test#mylanguage#myrunner#executable
M.executable = function()
  return "nix-unit"
end

return {
  -- Tests
  --
  {
    "vim-test/vim-test",
    event = "VeryLazy",
    config = function()
      vim.g["test#preserve_screen"] = 0
      vim.g["test#neovim#start_normal"] = 1
      vim.g["test#neovim#reopen_window"] = 1
      vim.g["test#neovim#term_position"] = "vert"
      vim.g["test#strategy"] = "toggleterm"
      vim.g["test#rust#cargotest#test_options"] = "-- --test-threads 1 --nocapture"
      vim.g["test#javascript#denotest#options"] = "--allow-all"
      -- Set vitest priority when installed
      vim.g["test#javascript#runner"] = "vitest"
      -- Nix
      -- vim.g["test#custom_runners#nix"] = "nix-unit"
      -- local nix_test = require "configs.test"
      -- vim.g["test#nix#nix-unit#test_file"] = nix_test.test_file
      -- vim.g["test#nix#nix-unit#build_position"] = nix_test.build_position
      -- vim.g["test#nix#nix-unit#build_args"] = nix_test.build_args
      -- vim.g["test#nix#nix-unit#build_args"] = nix_test.executable
    end,
  },
  -- toggleterm vim-test dependency
  {
    "akinsho/toggleterm.nvim",
    lazy = false,
    version = "*",
    config = function()
      require("toggleterm").setup {
        size = function(term)
          return vim.o.columns * 0.4
        end,
        direction = "vertical",
        persist_size = false,
        hide_numbers = false,
        close_on_exit = false,
        shade_terminals = false,
        terminal_mappings = true,
        shell = "fish",
      }
    end,
  },
  {
    "nvim-neotest/neotest",
    lazy = false,
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- Lang
      "rouge8/neotest-rust",
      "markemmons/neotest-deno",
      "rcasia/neotest-bash",
      "marilari88/neotest-vitest",
    },
  },
}
