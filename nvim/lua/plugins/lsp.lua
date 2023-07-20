local specs = {}

local u = require("utils")

local cfgs = {}

cfgs.bashls = {}

cfgs.gopls = {
  settings = {
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
  },
}

cfgs.lua_ls = {
  settings = {
    Lua = {
      workspace = {
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

specs.neodev = { "folke/neodev.nvim", opts = {} },
specs.lspconfig = {
  "neovim/nvim-lspconfig",
  event = { "VeryLazy", "BufReadPost", "BufNewFile" },
  dependencies = {
    "folke/neodev.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    local on_attach = function(_, bufnr)
      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end
    end


    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)





    local lspconfig = require("lspconfig")
    lspconfig.gopls.setup(cfgs.gopls)
    lspconfig.lua_ls.setup(lsp.nvim_lua_ls(cfgs.lua_ls))

    lsp.setup_servers(servers)
    lsp.skip_server_setup({ 'hls' }) -- managed by haskell-tools
    lsp.setup()
  end,
}


return u.respec(specs)
