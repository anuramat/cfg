local specs = {}
local k = require('plug_keys')
local u = require('utils')
local fu = require('fmt_utils')

-- These servers will be ignored when trying to format
_G.fmt_blacklist = { 'lua_ls' }

local cfgs = {
  bashls = {},
  pyright = {},

  gopls = {
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

  lua_ls = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file('*', true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

specs.neodev = { 'folke/neodev.nvim', opts = {} }

specs.lspconfig = {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'folke/neodev.nvim',
    'hrsh7th/nvim-cmp',
  },
  config = function()
    local lspconfig = require('lspconfig')
    -- ~~~~~~~ Rounded borders for hover windows ~~~~~~~ --
    vim.diagnostic.config({ float = { border = 'rounded' } })
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
    vim.lsp.handlers['textDocument/signatureHelp'] =
      vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })
    require('lspconfig.ui.windows').default_options.border = 'rounded'
    -- ~~~~ Register capabilities (CMP completion) ~~~~~ --
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
    -- ~~~~~~~~~~~~~~~~ Set up servers ~~~~~~~~~~~~~~~~~ --
    for server, settings in pairs(cfgs) do
      lspconfig[server].setup({
        capabilities = capabilities,
        on_attach = function(client, buffer)
          k.lsp(buffer)
          fu.setup_autoformat(client, buffer)
        end,
        settings = settings,
      })
    end
  end,
}

specs.null = {
  -- TODO add border around info hover window
  'jose-elias-alvarez/null-ls.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = 'nvim-lua/plenary.nvim',
  config = function()
    local null_ls = require('null-ls')
    local fmt = null_ls.builtins.formatting
    null_ls.setup({
      sources = {
        fmt.shfmt.with({
          extra_args = { '-s', '-ci', '-bn' },
        }),
        fmt.stylua,
      },
      on_attach = function(client, buffer)
        k.lsp(buffer)
        fu.setup_autoformat(client, buffer)
      end,
    })
  end,
}

return u.values(specs)
