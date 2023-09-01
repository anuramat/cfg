local specs = {}
local k = require('plugkeys')
local u = require('utils')

specs.go = {
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
    'leoluz/nvim-dap-go',
  },
  config = function() end,
  keys = k.dap,
}

return u.values(specs)
