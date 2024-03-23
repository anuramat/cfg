local null_sources = require('plugins.lsp.null.sources')
local on_attach = require('utils.lsp.on_attach')

-- alternatives:
-- https://github.com/mfussenegger/nvim-lint -- linting
-- https://github.com/stevearc/conform.nvim -- formatting
-- no code actions tho
return {
  'nvimtools/none-ls.nvim', -- maintained 'jose-elias-alvarez/null-ls.nvim' fork
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = 'nvim-lua/plenary.nvim',
  config = function()
    local null_ls = require('null-ls')
    null_ls.setup({
      sources = null_sources(),
      on_attach = on_attach,
      border = vim.g.border,
    })
  end,
}
