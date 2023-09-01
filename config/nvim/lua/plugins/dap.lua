local specs = {}
local k = require('plugkeys')
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
      build_flags = '', -- build flags to pass to delve (because ones from args are ignored in dap mode)
    },
  },
}

specs.dap = {
  'mfussenegger/nvim-dap',
  dependencies = {
    'theHamsta/nvim-dap-virtual-text',
  },
  config = function() end,
  keys = k.dap,
}

specs.dap_vt = {
  'theHamsta/nvim-dap-virtual-text',
  opts = {},
}

-- TODO understand, move keys, rewrite
specs.dap_ui = {
  'rcarriga/nvim-dap-ui',
  -- stylua: ignore
  keys = {
    { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
    { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
  },
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
