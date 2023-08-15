local specs = {}
local fmt = require('fmt')
local k = require('plugkeys')
local u = require('utils')

-- These servers will be ignored when trying to format
_G.fmt_blacklist = { 'lua_ls' }

--- TODO write
---@param opts { primary: string[], fallback: string[] }
local function two_step(opts)
  local util = require('lspconfig.util')
  return function(fname)
    local primary_root = util.root_pattern(unpack(opts.primary))(fname)
    local fallback_root = util.root_pattern(unpack(opts.fallback))(fname)
    return primary_root or fallback_root
  end
end

local function cfgs()
  return {
    bashls = {},
    pyright = {},
    bufls = {},
    marksman = {},
    -- ccls = {},
    clangd = {},

    gopls = {
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
      root_dir = two_step({ primary = { '.git' }, fallback = { 'go.work', 'go.mod' } }),
    },
    lua_ls = {
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          },
          workspace = {
            checkThirdParty = false,
            library = u.get_lib_path('config'),
          },
          telemetry = {
            enable = false,
          },
        },
      },
    },
  }
end

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
    for name, cfg in pairs(cfgs()) do
      cfg.capabilities = capabilities
      cfg.on_attach = function(client, buffer)
        k.lsp(buffer)
        fmt.setup_lsp_af(client, buffer)
      end
      lspconfig[name].setup(cfg)
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
    local null_fmt = null_ls.builtins.formatting
    null_ls.setup({
      sources = {
        null_fmt.shfmt.with({
          extra_args = { '-s', '-ci', '-bn' },
        }),
        null_fmt.stylua,
      },
      on_attach = function(client, buffer)
        k.lsp(buffer)
        fmt.setup_lsp_af(client, buffer)
      end,
    })
  end,
}

return u.values(specs)
