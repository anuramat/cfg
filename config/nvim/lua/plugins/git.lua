local specs = {}
local k = require('plug_keys')
local u = require('utils')

specs.fugitive = {
  'tpope/vim-fugitive',
  lazy = false, -- so that merge tool works
}

specs.signs = {
  'lewis6991/gitsigns.nvim',
  event = 'VeryLazy',
  opts = {
    signs = {
      add = { text = '▎' },
      change = { text = '▎' },
      delete = { text = '' },
      topdelete = { text = '' },
      changedelete = { text = '▎' },
      untracked = { text = '▎' },
    },
    on_attach = k.gitsigns
  },
}

return u.values(specs)
