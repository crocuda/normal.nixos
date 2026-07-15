-- local lspconfig = require "nvchad.configs.lspconfig"

-- local on_attach = lspconfig.on_attach
-- local on_init = lspconfig.on_init
-- local capabilities = lspconfig.capabilities

-- Load nvchad lsp defaults
-- local nvlsp = require "nvchad.configs.lspconfig"
-- nvlsp.defaults()

local servers = {
  -- Lua
  "lua_ls",

  -- Nix
  "nil_ls",
  -- "rnix", main contributor has passed away (will fork)

  -- Markup
  "taplo",
  "yamlls",
  "marksman",
  "tinymist",

  -- Go
  "gopls",

  -- Python
  "pylsp",

  -- Zig
  "zls",

  --sql
  "sqls",

  -- Web / Vue
  "html",
  -- "cssls",

  -- 3D
  "openscad_lsp",

  -- C/C++
  -- "clangd",
  "ccls",
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    -- on_attach = on_attach,
    -- on_init = on_init,
    -- capabilities = capabilities,
  })

  vim.lsp.enable(lsp)
end

-- Pug
-- Install pug lsp from go with: go install github.com/opa-oz/pug-lsp@latest
vim.lsp.config("pug", {
  -- on_attach = on_attach,
  -- on_init = on_init,
  -- capabilities = capabilities,
  root_dir = vim.fn.getcwd(),
})
vim.lsp.enable "pug"

vim.lsp.config("tailwindcss", {
  -- on_attach = on_attach,
  -- on_init = on_init,
  -- capabilities = capabilities,
  filetypes = { "pug", "css", "html", "vue", "postcss", "markdown", "svelte", "handlebars", "mustache", "jade", "htmx" },
})
-- vim.lsp.enable "tailwindcss"

vim.lsp.config("denols", {
  -- on_attach = on_attach,
  -- on_init = on_init,
  -- capabilities = capabilities,
  root_marker = { "deno.lock", "deno.json", "mod.ts" },
})
vim.lsp.enable "denols"

-- support for rust
vim.lsp.config("rust_analyzer", {
  settings = {
    -- Autoreload cargo at start for better completion -> avoid typing ":CargoReload" every time
    -- https://github.com/rust-lang/rust-analyzer/blob/master/docs/user/generated_config.adoc
    ["rust-analyzer.rust-analyzer.workspace.discoverConfig"] = {
      ["command"] = {
        "rust-project",
        "develop-json",
      },
      ["progressLabel"] = "rust-analyzer",
      ["filesToWatch"] = {
        "BUCK",
      },
    },
  },
})
vim.lsp.enable "rust_analyzer"

-- Grammar correction
-- https://medium.com/@Erik_Krieg/free-and-open-source-grammar-correction-in-neovim-using-ltex-and-n-grams-dea9d10bc964
vim.lsp.config("ltex", {
  settings = {
    ltex = {
      language = "en-GB",
      additionalRules = {
        languageModel = "~/Documents/Ngrams/",
      },
    },
  },
  filetypes = {
    "markdown",
    "typst",
  },
})
vim.lsp.enable "ltex"

-- Diagnostic styling
-- Enable diagnostic floating window on insert mode
--
vim.diagnostic.config {
  -- float = "always",
  virtual_text = false,
  severity_sort = true,
}
-- Toggle diagnostic virtual text
local function diagnostic_floating_window()
  vim.diagnostic.open_float(nil, { focus = false })
end
vim.api.nvim_create_autocmd("CursorHoldI", { callback = diagnostic_floating_window })

-- Configuration from:
-- https://github.com/vuejs/language-tools/wiki/Neovim

-- If you are using mason.nvim, you can get the ts_plugin_path like this
-- For Mason v1,
-- local mason_registry = require('mason-registry')
-- local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server'
-- For Mason v2,
-- local vue_language_server_path = vim.fn.expand '$MASON/packages' .. '/vue-language-server' .. '/node_modules/@vue/language-server'
-- or even
-- local vue_language_server_path = vim.fn.stdpath('data') .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

-- IMPORTANT: nvchad users cannot use `$MASON` directly as the option is set to `skip`, see: https://github.com/NvChad/NvChad/blob/29ebe31ea6a4edf351968c76a93285e6e108ea08/lua/nvchad/configs/mason.lua#L4

local vue_language_server_path = "./node_modules/@vue/language-server"
local tsserver_filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }

local vue_plugin = {
  name = "@vue/typescript-plugin",
  location = vue_language_server_path,
  languages = { "vue" },
  configNamespace = "typescript",
}
local pug_plugin = {
  name = "@vue/language-plugin-pug",
  location = vue_language_server_path,
  languages = { "vue" },
  configNamespace = "typescript",
}
local vtsls_config = {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          vue_plugin,
          pug_plugin,
        },
      },
    },
  },
  filetypes = tsserver_filetypes,
  root_markers = { "vite.config.ts", "vitest.config.ts" },
}

local ts_ls_config = {
  init_options = {
    plugins = {
      vue_plugin,
    },
  },
  filetypes = tsserver_filetypes,
  root_markers = { "tsconfig.json", "vite.config.ts", "vitest.config.ts" },
  settings = {
    typescript = {
      tsserver = {
        useSyntaxServer = false,
      },
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
}

-- If you are not on most recent `nvim-lspconfig` or you want to override
local vue_ls_config = {
  cmd = { "bun", "run", "vue-language-server", "--stdio" },
  init_options = {
    vue = {
      hybridMode = true,
    },
  },
  root_markers = { "vite.config.ts", "vitest.config.ts" },
  settings = {
    pug = {
      validate = true,
    },
    css = {
      validate = true,
      lint = {
        unknownAtRules = "ignore",
      },
    },
    scss = {
      validate = true,
      lint = {
        unknownAtRules = "ignore",
      },
    },
    less = {
      validate = true,
      lint = {
        unknownAtRules = "ignore",
      },
    },
  },
  on_init = function(client)
    client.handlers["tsserver/request"] = function(_, result, context)
      local ts_clients = vim.lsp.get_clients { bufnr = context.bufnr, name = "ts_ls" }
      local vtsls_clients = vim.lsp.get_clients { bufnr = context.bufnr, name = "vtsls" }
      local clients = {}

      vim.list_extend(clients, ts_clients)
      vim.list_extend(clients, vtsls_clients)

      if #clients == 0 then
        vim.notify(
          "Could not find `vtsls` or `ts_ls` lsp client, `vue_ls` would not work without it.",
          vim.log.levels.ERROR
        )
        return
      end
      local ts_client = clients[1]

      local param = table.unpack(result)
      local id, command, payload = table.unpack(param)
      ts_client:exec_cmd({
        title = "vue_request_forward", -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
        command = "typescript.tsserverRequest",
        arguments = {
          command,
          payload,
        },
      }, { bufnr = context.bufnr }, function(_, r)
        local response = r and r.body
        -- TODO: handle error or response nil here, e.g. logging
        -- NOTE: Do NOT return if there's an error or no response, just return nil back to the vue_ls to prevent memory leak
        local response_data = { { id, response } }

        ---@diagnostic disable-next-line: param-type-mismatch
        client:notify("tsserver/response", response_data)
      end)
    end
  end,
}
-- nvim 0.11 or above
vim.lsp.config("vtsls", vtsls_config)
vim.lsp.config("vue_ls", vue_ls_config)
vim.lsp.config("ts_ls", ts_ls_config)
vim.lsp.enable { "ts_ls", "vue_ls" } -- If using `ts_ls` replace `vtsls` to `ts_ls`

return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
  },
}
