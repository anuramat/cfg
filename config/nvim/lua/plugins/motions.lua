local specs = {}
local k = require('plugkeys')
local u = require('utils')

specs.flash = {
  -- TODO move to space-s
  -- make s=surround (?)
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
