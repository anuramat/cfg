local specs = {}

local u = require("utils")

local pref = "Haskell Tools: "
local function get_opts(b, d)
  return { buffer = b, desc = pref .. d }
end

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
        on_attach = function(_, buf)
          vim.keymap.set('n', '<leader>ca', vim.lsp.codelens.run, get_opts(buf, "Run CodeLens"))
          vim.keymap.set('n', '<leader>hs', ht.hoogle.hoogle_signature, get_opts(buf, "Show Hoogle Signature"))
          vim.keymap.set('n', '<leader>ea', ht.lsp.buf_eval_all, get_opts(buf, "Evaluate All"))
        end
      }
    }
    local hls_augroup = vim.api.nvim_create_augroup('haskell-lsp', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      group = hls_augroup,
      pattern = { 'haskell' },
      callback = function()
        ht.start_or_attach(hls_config)
        local buf = vim.api.nvim_get_current_buf()
        vim.keymap.set('n', '<leader>rr', ht.repl.toggle, get_opts(buf, "Toggle Package REPL"))
        vim.keymap.set('n', '<leader>rf',
          function() ht.repl.toggle(vim.api.nvim_buf_get_name(0)) end, get_opts(buf, "Toggle Buffer REPL"))
        vim.keymap.set('n', '<leader>rq', ht.repl.quit, get_opts(buf, "Quit REPL"))
        -- Detect nvim-dap launch configurations
        -- (requires nvim-dap and haskell-debug-adapter)
        -- ht.dap.discover_configurations(bufnr) -- requires dap
      end,
    })
  end
}


return u.respec(specs)
