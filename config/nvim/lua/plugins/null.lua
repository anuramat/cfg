local specs = {}
local lsp_utils = require('lsp.utils')
local u = require('utils')

-- alternatives:
-- https://github.com/mfussenegger/nvim-lint -- linting
-- https://github.com/stevearc/conform.nvim -- formatting
-- no code actions tho
specs.null = {
  'nvimtools/none-ls.nvim', -- maintained 'jose-elias-alvarez/null-ls.nvim' fork
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = 'nvim-lua/plenary.nvim',
  config = function()
    local null_ls = require('null-ls')
    local nlf = null_ls.builtins.formatting
    local nld = null_ls.builtins.diagnostics
    local nla = null_ls.builtins.code_actions
    null_ls.setup({
      sources = {
        nlf.shfmt.with({ extra_args = { '-s', '-ci', '-bn' } }),
        nlf.stylua,
        nlf.black,
        -- nlf.nixfmt,
        nlf.alejandra,
        nld.deadnix,
        nld.statix,
        nla.statix,
        -- nld.protolint,
      },
      on_attach = lsp_utils.default_on_attach,
      border = vim.g.border,
    })
  end,
}

return u.values(specs)
