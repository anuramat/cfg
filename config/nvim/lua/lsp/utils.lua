local M = {}

--- Root directory function with a fallback
--- @param opts { primary: string[], fallback: string[] }
M.root_dir_with_fallback = function(opts)
  local util = require('lspconfig.util')
  return function(fname)
    local primary_root = util.root_pattern(unpack(opts.primary))(fname)
    local fallback_root = util.root_pattern(unpack(opts.fallback))(fname)
    return primary_root or fallback_root
  end
end

-- TODO docstring
--- creates autoformat autocommand, toggling commands
function M.default_on_attach(client, buffer)
  require('lsp.keys').setup_lsp_keybinds(buffer)
  require('lsp.formatting').setup_lsp_autoformatting(client, buffer)
end

return M
