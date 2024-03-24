local M = {}

-- These servers will be ignored when trying to format
M.fmt_srv_blacklist = {}

M.fmt_ft_blacklist = {
  'proto', -- HACK, for some reason null-ls tries to format with diagnostics.protolint or something
}

return M
