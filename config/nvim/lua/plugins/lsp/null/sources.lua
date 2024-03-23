-- TODO docstring
return function()
  local null_ls = require('null-ls')
  local nlf = null_ls.builtins.formatting
  local nld = null_ls.builtins.diagnostics
  local nla = null_ls.builtins.code_actions

  return {
    nlf.shfmt.with({ extra_args = { '-s', '-ci', '-bn' } }),
    nlf.stylua,
    nlf.black,
    -- nlf.nixfmt,
    nlf.alejandra,
    nld.deadnix,
    nld.statix,
    nla.statix,
    -- nld.protolint,
  }
end
