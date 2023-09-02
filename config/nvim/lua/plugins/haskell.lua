local specs = {}
local fu = require('fmt')
local k = require('plugkeys')
local u = require('utils')

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
          fu.setup_lsp_af(client, buffer)
          k.haskell_tools(buffer)
          k.lsp(buffer)
          ht.dap.discover_configurations(buffer)
        end,
      },
    }
    require('telescope').load_extension('ht')
  end,
}

return u.values(specs)
