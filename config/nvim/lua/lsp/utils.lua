local M = {}

-- TODO docstring
--- creates autoformat autocommand, toggling commands
function M.default_on_attach(client, buffer)
  require('lsp.keys').setup_lsp_keybinds(buffer)
  require('lsp.formatting').setup_lsp_autoformatting(client, buffer)
end

return M
