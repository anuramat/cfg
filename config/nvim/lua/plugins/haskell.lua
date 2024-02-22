local specs = {}
local lsp_utils = require('lsp_utils')
local u = require('utils')

local function repl_toggler(ht, buffer)
  return function()
    ht.repl.toggle(vim.api.nvim_buf_get_name(buffer))
  end
end

specs.haskell = {
  'mrcjkb/haskell-tools.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  version = '^3',
  ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    vim.g.haskell_tools = {
      hls = {
        capabilities = capabilities,
        on_attach = function(client, buffer, ht)
          lsp_utils.default_on_attach(client, buffer)

          local s = function(lhs, rhs, desc)
            vim.keymap.set('n', '<leader>L' .. lhs, rhs, { buffer = buffer, desc = 'Haskell: ' .. desc })
          end

          s('b', repl_toggler(ht, buffer), 'Toggle Buffer REPL')
          s('e', ht.lsp.buf_eval_all, 'Evaluate All')
          s('h', ht.hoogle.hoogle_signature, 'Show Hoogle Signature')
          s('p', ht.repl.toggle, 'Toggle Package REPL')
          s('q', ht.repl.quit, 'Quit REPL')

          ht.dap.discover_configurations(buffer, { autodetect = true, settings_file_pattern = 'launch.json' })
        end,
      },
    }
    require('telescope').load_extension('ht')
  end,
}

return u.values(specs)
