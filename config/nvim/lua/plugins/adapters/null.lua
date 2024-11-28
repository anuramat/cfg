-- vim: fdl=0

local function latexindent()
  -- already used in texlab
  local null_ls = require('null-ls')
  local helpers = require('null-ls.helpers')
  null_ls.register({
    name = 'latexindent',
    method = null_ls.methods.FORMATTING,
    filetypes = { 'tex' },
    generator = helpers.formatter_factory({
      command = 'latexindent',
      args = { '$FILENAME' },
    }),
  })
end

-- codeblock formatter for markdown
local function cbfmt()
  -- sources are set in $XDG_CONFIG_HOME/cbfmt.toml
  local null_ls = require('null-ls')
  local helpers = require('null-ls.helpers')
  null_ls.register({
    name = 'cbfmt',
    method = null_ls.methods.FORMATTING,
    filetypes = { 'markdown' },
    generator = helpers.formatter_factory({
      to_stdin = true,
      command = 'cbfmt',
      args = { '--config', vim.fn.expand('$XDG_CONFIG_HOME') .. '/cbfmt.toml', '-p', 'markdown' },
    }),
  })
end

local null_sources = function()
  local null_ls = require('null-ls')
  local nlf = null_ls.builtins.formatting
  local nld = null_ls.builtins.diagnostics
  local nla = null_ls.builtins.code_actions

  return {
    -- ~~~~~~~~~~~~~~~~~~~ formatting ~~~~~~~~~~~~~~~~~~~ --
    nlf.shfmt.with({ extra_args = { '-s', '-ci', '-bn' } }),
    nlf.stylua,
    nlf.black,
    nlf.alejandra,
    -- nlf.prettier.with({
    --   extra_args = {
    --     '--print-width',
    --     tostring(vim.o.textwidth),
    --     '--prose-wrap',
    --     'always',
    --   },
    -- }),
    cbfmt,
    -- diagnostics
    nld.deadnix,
    nld.statix,
    nld.protolint,
    -- actions
    nla.statix,
  }
end

local on_attach = require('utils.lsp').on_attach

-- alternatives:
-- - mfussenegger/nvim-lint -- linting
-- - stevearc/conform.nvim -- formatting
-- - mhartington/formatter.nvim
-- - mattn/efm-langserver -- actual LSP server, works with error messages
-- - lewis6991/hover.nvim -- hover provider
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
