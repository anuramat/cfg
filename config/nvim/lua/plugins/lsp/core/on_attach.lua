--- default on_attach
return function(client, buffer)
  require('plugins.lsp.core.keys')(buffer)
  require('lsp-format').on_attach(client, buffer)
  vim.lsp.inlay_hint.enable(buffer)
end
