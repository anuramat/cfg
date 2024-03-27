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

local function cbfmt()
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

-- TODO docstring
return function()
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
    nlf.prettier,
    cbfmt,
    -- ~~~~~~~~~~~~~~~~~~ diagnostics ~~~~~~~~~~~~~~~~~~~ --
    nld.deadnix,
    nld.statix,
    nld.protolint,
    -- ~~~~~~~~~~~~~~~~~~ code actions ~~~~~~~~~~~~~~~~~~ --
    nla.statix,
  }
end
