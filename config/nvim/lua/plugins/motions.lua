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
      '<leader>s',
      mode = 'n',
      function()
        require('flash').jump()
      end,
      desc = 'Jump',
    },
    {
      '<leader>s',
      mode = 'o',
      function()
        require('flash').treesitter()
      end,
      desc = 'TS node',
    },
  },
}

return u.values(specs)
