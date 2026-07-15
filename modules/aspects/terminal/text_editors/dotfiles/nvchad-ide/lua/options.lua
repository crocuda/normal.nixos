require "nvchad.options"

-- Fix focus.nvim warning
-- vim.o.winwidth = 30
-- vim.api.nvim_set_option("winwidth", 60)

vim.o.colorcolumn = "80"
-- vim.api.nvim_set_option("colorcolumn", "80")

vim.o.clipboard = "unnamed"
vim.o.clipboard = "unnamedplus"
vim.o.splitbelow = true
vim.o.splitright = true

vim.api.nvim_set_option("clipboard", "unnamed")
vim.api.nvim_set_option("clipboard", "unnamedplus")
