local specs = {}
local k = require('plugkeys')
local u = require('utils')

specs.dap = {
  'mfussenegger/nvim-dap',
  config = function() end,
  keys = k.dap,
}

return u.values(specs)
