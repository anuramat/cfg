local specs = {}

local u = require("utils")
local k = require("config.keys")

local cfgs = {}

cfgs.bashls = {}
cfgs.pyright = {}

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
    -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ui borders ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
    vim.diagnostic.config { float = { border = "rounded" } }
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })
    require('lspconfig.ui.windows').default_options.border = 'rounded'
    -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ mappings ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
    local on_attach = function(_, buffer)
      k.lsp_set(buffer)
    end
    -- ~~~~~~~~~~~~~~~~~~~~~~ configure lsps and cmp ~~~~~~~~~~~~~~~~~~~~~~~ --
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

specs.saga = {
  'nvimdev/lspsaga.nvim',
  event = 'LspAttach',
  opts = {
    lightbulb = { enable = false }
  },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  keys = k.lspsaga_lazy(),
}

return u.values(specs)
