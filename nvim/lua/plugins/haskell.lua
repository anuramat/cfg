local specs = {}

local u = require("utils")

specs.haskell = {
  "mrcjkb/haskell-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  branch = "1.x.x",
  ft = "haskell",
  config = function()
    local ht = require('haskell-tools')
    local hls_lsp = require('lsp-zero').build_options('hls', {})
    local hls_config = {
      hls = {
        capabilities = hls_lsp.capabilities,
        on_attach = function(_, bufnr)
          local opts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set('n', '<leader>ca', vim.lsp.codelens.run, opts)
          vim.keymap.set('n', '<leader>hs', ht.hoogle.hoogle_signature, opts)
          vim.keymap.set('n', '<leader>ea', ht.lsp.buf_eval_all, opts)
        end
      }
    }
    local hls_augroup = vim.api.nvim_create_augroup('haskell-lsp', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      group = hls_augroup,
      pattern = { 'haskell' },
      callback = function()
        ht.start_or_attach(hls_config)
        local bufnr = vim.api.nvim_get_current_buf()
        local opts = { noremap = true, silent = true, buffer = bufnr }
        -- Toggle a GHCi repl for the current package
        vim.keymap.set('n', '<leader>rr', ht.repl.toggle, opts)
        -- Toggle a GHCi repl for the current buffer
        vim.keymap.set('n', '<leader>rf', function() ht.repl.toggle(vim.api.nvim_buf_get_name(0)) end, opts)
        vim.keymap.set('n', '<leader>rq', ht.repl.quit, opts)
        -- Detect nvim-dap launch configurations
        -- (requires nvim-dap and haskell-debug-adapter)
        -- ht.dap.discover_configurations(bufnr) -- requires dap
      end,
    })
  end
}


return u.respec(specs)
