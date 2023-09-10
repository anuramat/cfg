local specs = {}
local lsp_utils = require('lsp_utils')
local u = require('utils')

local s = vim.keymap.set
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
  branch = '2.x.x',
  ft = { 'haskell', 'lhaskell', 'cabal' },
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
    vim.g.haskell_tools = {
      hls = {
        capabilities = capabilities,
        on_attach = function(client, buffer, ht)
          lsp_utils.setup_lsp_af(client, buffer)

          s('n', '<leader>sb', repl_toggler(ht, buffer), { buffer = buffer, desc = 'Toggle Buffer REPL' })
          s('n', '<leader>se', ht.lsp.buf_eval_all, { buffer = buffer, desc = 'Evaluate All' })
          s('n', '<leader>sh', ht.hoogle.hoogle_signature, { buffer = buffer, desc = 'Show Hoogle Signature' })
          s('n', '<leader>sp', ht.repl.toggle, { buffer = buffer, desc = 'Toggle Package REPL' })
          s('n', '<leader>sq', ht.repl.quit, { buffer = buffer, desc = 'Quit REPL' })

          lsp_utils.lsp_keys(buffer)

          ht.dap.discover_configurations(buffer)
        end,
      },
    }
    require('telescope').load_extension('ht')
  end,
}

return u.values(specs)
