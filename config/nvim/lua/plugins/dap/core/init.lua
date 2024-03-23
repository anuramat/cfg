local u = require('utils')

local function log_point()
  require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
end

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    {
      'theHamsta/nvim-dap-virtual-text',
      opts = {},
    },
  },
  config = function() end,
  -- stylua: ignore
  keys = u.lazy_prefix('<leader>d', {
    { 'c', function() require('dap').continue() end,          desc = 'Continue' },
    { 'o', function() require('dap').step_out() end,          desc = 'Step Out' },
    { 'n', function() require('dap').step_over() end,         desc = 'Step Over' },
    { 'i', function() require('dap').step_into() end,         desc = 'Step Into' },
    -- { 's', function() require('dap').set_breakpoint() end,    desc = 'Set Breakpoint' },
    { 'b', function() require('dap').toggle_breakpoint() end, desc = 'Toggle Breakpoint' },
    { 'l', log_point,                                         desc = 'Set Log Point' },
    { 'r', function() require('dap').repl.open() end,         desc = 'Open Debug REPL' },
    { 'd', function() require('dap').run_last() end,          desc = 'Run Last Debug Session' },
  }, "DAP"),
}
