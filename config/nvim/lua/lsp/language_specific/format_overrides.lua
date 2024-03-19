M = {}
-- These servers will be ignored when trying to format
M.fmt_srv_blacklist = {
  'lua_ls', -- using stylua instead
  'nil_ls', -- using alejandra
}

M.fmt_ft_blacklist = {
  'proto', -- HACK, for some reason null-ls tries to format with diagnostics.protolint or something
}

return M
