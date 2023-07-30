local specs = {}

local u = require("utils")
local k = require("config.keys")

local function get_opts(b, d)
  return { buffer = b, desc = "Haskell Tools: " .. d }
end

specs.haskell = {
  "mrcjkb/haskell-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  branch = "1.x.x",
  ft = { "haskell", "lhaskell", "cabal" },
  config = function()
    require('telescope').load_extension('ht')
    local ht = require('haskell-tools')
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local hls_config = {
      hls = {
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities),
        on_attach = function(_, buf)
          k.haskell_tools.lsp(buf)
          k.lsp(buf)
        end
      }
    }
    local hls_augroup = vim.api.nvim_create_augroup('haskell-lsp', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      group = hls_augroup,
      pattern = { "haskell", "lhaskell", "cabal" },
      callback = function()
        ht.start_or_attach(hls_config)
        local buf = vim.api.nvim_get_current_buf()
        k.haskell_tools.main(buf)
        -- Detect nvim-dap launch configurations
        -- (requires nvim-dap and haskell-debug-adapter)
        -- ht.dap.discover_configurations(bufnr)
      end,
    })
  end
}


return u.values(specs)
