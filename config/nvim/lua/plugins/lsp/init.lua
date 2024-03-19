local configs = require('plugins.lsp.configs')
local on_attach = require('utils.lsp.on_attach')

return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'hrsh7th/nvim-cmp',
    'ray-x/lsp_signature.nvim',
  },
  config = function()
    local lspconfig = require('lspconfig')
    -- ~~~~~~~~~~~~~~~~ Borders styling ~~~~~~~~~~~~~~~~~ --
    require('lspconfig.ui.windows').default_options.border = vim.g.border -- :LspInfo

    -- -- add border to default hover handler (replaced by folke/noice.nvim)
    -- vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = vim.g.border })
    -- -- add border to default signature help (replaced with ray-x/lsp_signature.nvim)
    -- vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = vim.g.border })
    -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
    -- Register capabilities for CMP
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
    -- ~~~~~~~~~~~~~~~~ Set up servers ~~~~~~~~~~~~~~~~~ --
    for name, cfg in pairs(configs.cfgs()) do
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
