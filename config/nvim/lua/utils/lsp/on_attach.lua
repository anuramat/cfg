--- default on_attach
return function(client, buffer)
  require('utils.lsp.keys')(buffer)
  require('lsp-format').on_attach(client, buffer)
  vim.lsp.inlay_hint.enable()
end
