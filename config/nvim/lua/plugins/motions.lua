local specs = {}
local k = require('plug_keys')
local u = require('utils')

specs.flash = {
  'folke/flash.nvim',
  opts = {
    modes = {
      search = { enabled = false },
      char = { enabled = false },
    },
  },
  keys = k.flash(),
}

specs.readline = {
  'linty-org/readline.nvim',
  keys = k.readline,
}

return u.values(specs)
