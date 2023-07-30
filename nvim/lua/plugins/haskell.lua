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
          vim.keymap.set('n', '<leader>hh', ht.hoogle.hoogle_signature,
            get_opts(buf, "Haskell Tools: Show Hoogle Signature"))
          vim.keymap.set('n', '<leader>he', ht.lsp.buf_eval_all, get_opts(buf, "Haskell Tools: Evaluate All"))
          k.lsp_set_mappings(buf)
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
        vim.keymap.set('n', '<leader>hrp', ht.repl.toggle, get_opts(buf, "Haskell Tools: Toggle Package REPL"))
        vim.keymap.set('n', '<leader>hrb',
          function() ht.repl.toggle(vim.api.nvim_buf_get_name(0)) end, get_opts(buf, "Haskell Tools: Toggle Buffer REPL"))
        vim.keymap.set('n', '<leader>hrq', ht.repl.quit, get_opts(buf, "Haskell Tools: Quit REPL"))
        -- Detect nvim-dap launch configurations
        -- (requires nvim-dap and haskell-debug-adapter)
        -- ht.dap.discover_configurations(bufnr)
      end,
    })
  end
}


return u.values(specs)
