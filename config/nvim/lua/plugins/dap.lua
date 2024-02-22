local specs = {}
local u = require('utils')

specs.dap_go = {
  'leoluz/nvim-dap-go',
  ft = 'go',
  opts = {
    dap_configurations = {
      {
        type = 'go',
        name = 'Attach remote',
        mode = 'remote',
        request = 'attach',
      },
    },
    delve = {
      path = 'dlv',
      initialize_timeout_sec = 20,
      port = '${port}', -- ${port} for random port
      args = {}, -- additional args to pass to delve
      build_flags = '', -- build flags to pass to delve (because flags from args are ignored in dap mode)
    },
  },
}

local function log_point()
  require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
end

specs.dap = {
  'mfussenegger/nvim-dap',
  dependencies = {
    'theHamsta/nvim-dap-virtual-text',
  },
  config = function() end,
  -- stylua: ignore
  keys = u.prefix('<leader>d', {
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

specs.dap_vt = {
  'theHamsta/nvim-dap-virtual-text',
  opts = {},
}

-- TODO understand, move keys, rewrite
specs.dap_ui = {
  'rcarriga/nvim-dap-ui',
  -- stylua: ignore
  keys = u.prefix('<leader>d', {
    { "u", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
    { "e", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
  }, "DAP"),
  opts = {},
  config = function(_, opts)
    local dap = require('dap')
    local dapui = require('dapui')
    dapui.setup(opts)
    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open({})
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close({})
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close({})
    end
  end,
}

return u.values(specs)
