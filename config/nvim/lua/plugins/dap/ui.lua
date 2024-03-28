local u = require('utils')

return {
  'rcarriga/nvim-dap-ui',
  dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
  -- stylua: ignore
  keys = u.lazy_prefix('<leader>d', {
    { "u", function() require("dapui").toggle() end, desc = "Dap UI" },
    { "e", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
  }, "DAP"),
  opts = {
    -- setting up default settings explicitly just in case
    floating = {
      border = 'single',
      mappings = {
        close = { 'q', '<Esc>' },
      },
    },
    {
      edit = 'e',
      expand = { '<CR>', '<2-LeftMouse>' },
      open = 'o',
      remove = 'd',
      repl = 'r',
      toggle = 't',
    },
  },
}
