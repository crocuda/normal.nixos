vim.g.mapleader = " "

require "configs.lazy"

require "options"

-- load mapping
vim.schedule(function()
  require "mappings"
end)
