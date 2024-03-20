local specs = {}
local u = require('utils')

specs.flash = {
  'folke/flash.nvim',
  opts = {
    modes = {
      search = { enabled = false },
      char = { enabled = false },
    },
  },
  keys = {
    {
      's',
      mode = 'n',
      function()
        require('flash').jump()
      end,
      desc = 'Jump',
    },
    {
      'r',
      mode = 'o',
      function()
        require('flash').treesitter()
      end,
      desc = 'TS node',
    },
  },
}

specs.brackets = {
  'echasnovski/mini.bracketed',
  lazy = false,
  opts = {},
}

return u.values(specs)
