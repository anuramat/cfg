local specs = {}

local u = require("utils")

local cfgs = {}

cfgs.bashls = {}

cfgs.gopls = {
  gopls = {
    analyses = {
      fieldalignment = true,
      nilness = true,
      shadow = true,
      unusedparams = true,
      unusedwrite = true,
      useany = true,
      unusedvariable = true,
    },
    staticcheck = true,
    gofumpt = true,
  },
}

cfgs.lua_ls = {
  Lua = {
    runtime = {
      -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
      version = 'LuaJIT',
    },
    workspace = {
      checkThirdParty = false,
      library = vim.api.nvim_get_runtime_file("*", true),
    },
    telemetry = {
      enable = false,
    },
  },
}

specs.neodev = { "folke/neodev.nvim", opts = {} }

specs.lspconfig = {
  "neovim/nvim-lspconfig",
  event = { "VeryLazy", "BufReadPost", "BufNewFile" },
  dependencies = {
    "folke/neodev.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    local lspconfig = require("lspconfig")

    local on_attach = function(_, bufnr)
      local nmap = function(keys, func, desc)
        if desc then
          desc = 'lsp: ' .. desc
        end
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end
    end


    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    for server, settings in pairs(cfgs) do
      lspconfig[server].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = settings,
      })
    end
  end,
}


return u.respec(specs)
