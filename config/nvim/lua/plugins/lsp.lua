local specs = {}
local lsp_utils = require('lsp_utils')
local u = require('utils')

-- These servers will be ignored when trying to format
_G.fmt_srv_blacklist = { 'lua_ls' }
_G.fmt_ft_blacklist = {
  'proto', -- HACK, for some reason null-ls tries to format with diagnostics.protolint or something
}

--- Root directory function with a fallback
--- @param opts { primary: string[], fallback: string[] }
local function root_dir_with_fallback(opts)
  local util = require('lspconfig.util')
  return function(fname)
    local primary_root = util.root_pattern(unpack(opts.primary))(fname)
    local fallback_root = util.root_pattern(unpack(opts.fallback))(fname)
    return primary_root or fallback_root
  end
end

--- Returns configs for specific lsps
--- @return table configs
local function cfgs()
  return {
    -- nil_ls = {}, -- better diagnostics in some regards
    nixd = {},
    yamlls = {},

    bashls = {},
    pyright = {},
    marksman = {},
    clangd = {
      on_attach = function(client, buffer)
        lsp_utils.lsp_keys(buffer)
        vim.api.nvim_buf_set_keymap(
          buffer,
          'n',
          '<leader>sh',
          '<cmd>ClangdSwitchSourceHeader<cr>',
          { silent = true, desc = 'clangd: Switch between .c/.h' }
        )
        lsp_utils.setup_lsp_af(client, buffer)
        require('clangd_extensions.inlay_hints').setup_autocmd()
        require('clangd_extensions.inlay_hints').set_inlay_hints()
      end,
      filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' }, -- 'proto' removed
    },

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
      root_dir = root_dir_with_fallback({ primary = { '.git' }, fallback = { 'go.work', 'go.mod' } }),
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

-- TODO clangd ext keymaps
specs.clangd_extensions = { 'p00f/clangd_extensions.nvim' }

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
      if cfg.on_attach == nil then
        cfg.on_attach = function(client, buffer)
          lsp_utils.lsp_keys(buffer)
          lsp_utils.setup_lsp_af(client, buffer)
        end
      end
      lspconfig[name].setup(cfg)
    end
  end,
}

specs.null = {
  'jose-elias-alvarez/null-ls.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = 'nvim-lua/plenary.nvim',
  config = function()
    local null_ls = require('null-ls')
    local nlf = null_ls.builtins.formatting
    local nld = null_ls.builtins.diagnostics
    null_ls.setup({
      sources = {
        nlf.shfmt.with({ extra_args = { '-s', '-ci', '-bn' } }),
        nlf.stylua,
        nld.protolint,
      },
      on_attach = function(client, buffer)
        lsp_utils.lsp_keys(buffer)
        lsp_utils.setup_lsp_af(client, buffer)
      end,
      border = 'rounded',
    })
  end,
}

return u.values(specs)
