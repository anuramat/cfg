return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'hrsh7th/nvim-cmp',
    'ray-x/lsp_signature.nvim',
    'lukas-reineke/lsp-format.nvim',
    -- 'folke/neodev.nvim', -- not an actual dependency, a hack to get neodev setup before lspconfig
  },
  config = function()
    local lspconfig = require('lspconfig')
    local configs = require('plugins.lsp.core.configs')
    local on_attach = require('plugins.lsp.core.on_attach')
    -- ~~~~~~~~~~~~~~~~ Borders styling ~~~~~~~~~~~~~~~~~ --
    -- add border to `:LspInfo` menu
    require('lspconfig.ui.windows').default_options.border = vim.g.border
    -- -- add border to default hover handler (replaced by folke/noice.nvim)
    -- vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = vim.g.border })
    -- -- add border to default signature help (replaced with ray-x/lsp_signature.nvim)
    -- vim.lsp.handlers['textDocument/signatureHelp'] =
    --   vim.lsp.with(vim.lsp.handlers.signature_help, { border = vim.g.border })
    -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
    -- Register capabilities for CMP
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
    -- ~~~~~~~~~~~~~~~~ Set up servers ~~~~~~~~~~~~~~~~~ --
    for name, cfg in pairs(configs()) do
      cfg.capabilities = capabilities
      if cfg.on_attach == nil then
        cfg.on_attach = on_attach
      end
      lspconfig[name].setup(cfg)
    end

    require('lsp_signature').setup({
      handler_opts = { border = vim.g.border },
      always_trigger = true,
      hint_enable = false, -- virtual hint enable
      hint_prefix = '🐼 ', -- Panda for parameter (hehe)
    })
  end,
}
