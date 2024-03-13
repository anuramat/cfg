local specs = {}
local lsp_utils = require('lsp_utils')
local u = require('utils')

-- These servers will be ignored when trying to format
_G.fmt_srv_blacklist = {
  'lua_ls', -- using stylua instead
}
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

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
--- Returns configs for specific lsps
--- @return table configs
local function cfgs()
  return {
    nixd = {}, -- nil_ls -- better diagnostics in some regards
    yamlls = {},
    tsserver = {},
    texlab = {},
    bashls = {},
    pyright = {},
    marksman = {},
    clangd = {
      on_attach = function(client, buffer)
        vim.api.nvim_buf_set_keymap(
          buffer,
          'n',
          '<leader>sh',
          '<cmd>ClangdSwitchSourceHeader<cr>',
          { silent = true, desc = 'clangd: Switch between .c/.h' }
        )
        lsp_utils.default_on_attach(client, buffer)
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
            shadow = true,
            unusedwrite = true,
            useany = true,
            unusedvariable = true,
          },
          codelenses = {
            gc_details = true,
            generate = true,
            regenerate_cgo = true,
            tidy = true,
            upgrade_dependency = true,
            vendor = true,
          },
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
          usePlaceholders = true,
          staticcheck = true,
          gofumpt = true,
          semanticTokens = true,
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
          },
          telemetry = {
            enable = false,
          },
        },
      },
    },
  }
end

-- TODO clangd ext keymaps
specs.clangd_extensions = { 'p00f/clangd_extensions.nvim' }

specs.lspconfig = {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'hrsh7th/nvim-cmp',
    'ray-x/lsp_signature.nvim',
  },
  config = function()
    local lspconfig = require('lspconfig')
    -- ~~~~~~~~~~~~~~~~ Borders styling ~~~~~~~~~~~~~~~~~ --
    vim.diagnostic.config({ float = { border = vim.g.border } }) -- vim.diagnostic.open_float
    require('lspconfig.ui.windows').default_options.border = vim.g.border -- :LspInfo

    -- -- add border to default hover handler (should be replaced with noice, but noice fucks up the border color)
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = vim.g.border })
    -- -- add border to default signature help (replaced with ray-x/lsp_signature.nvim
    -- vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = vim.g.border })
    -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
    -- Register capabilities for CMP
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
    -- ~~~~~~~~~~~~~~~~ Set up servers ~~~~~~~~~~~~~~~~~ --
    for name, cfg in pairs(cfgs()) do
      cfg.capabilities = capabilities
      if cfg.on_attach == nil then
        cfg.on_attach = lsp_utils.default_on_attach
      end
      lspconfig[name].setup(cfg)
    end

    require('lsp_signature').setup({
      handler_opts = { border = 'shadow' },
      always_trigger = true,
      hint_enable = false, -- virtual hint enable
      hint_prefix = '🐼 ', -- Panda for parameter (hehe)
    })
  end,
}

specs.null = {
  'nvimtools/none-ls.nvim', -- maintained 'jose-elias-alvarez/null-ls.nvim' fork
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
        nlf.black,
        -- nld.protolint,
      },
      on_attach = lsp_utils.default_on_attach,
      border = vim.g.border,
    })
  end,
}

return u.values(specs)
