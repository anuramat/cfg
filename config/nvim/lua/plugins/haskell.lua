local specs = {}
local fu = require('fmt')
local k = require('plugkeys')
local u = require('utils')

specs.haskell = {
  'mrcjkb/haskell-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  branch = '1.x.x',
  ft = { 'haskell', 'lhaskell', 'cabal' },
  config = function()
    require('telescope').load_extension('ht')
    local ht = require('haskell-tools')
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local hk = k.haskell_tools()
    local hls_config = {
      hls = {
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities),
        on_attach = function(client, buffer)
          fu.setup_lsp_af(client, buffer)
          hk.lsp(buffer)
          k.lsp(buffer)
        end,
      },
    }
    local hls_augroup = vim.api.nvim_create_augroup('haskell-lsp', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      group = hls_augroup,
      pattern = { 'haskell', 'lhaskell', 'cabal' },
      callback = function()
        ht.start_or_attach(hls_config)
        local buf = vim.api.nvim_get_current_buf()
        hk.main(buf)
        -- Detect nvim-dap launch configurations
        -- (requires nvim-dap and haskell-debug-adapter)
        -- ht.dap.discover_configurations(bufnr)
      end,
    })
  end,
}

return u.values(specs)
