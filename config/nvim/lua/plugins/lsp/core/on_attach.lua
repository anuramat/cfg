-- TODO docstring
--- default on_attach
--- creates autoformat autocommand, toggling commands
return function(client, buffer)
  require('plugins.lsp.core.keys')(buffer)
  require('lsp-format').on_attach(client, buffer)
  vim.lsp.inlay_hint.enable(buffer)
end

