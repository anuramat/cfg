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

specs.undotree = {
  'mbbill/undotree',
  cmd = {
    'UndotreeHide',
    'UndotreeShow',
    'UndotreeFocus',
    'UndotreeToggle',
  },
  keys = k.undotree(),
}

specs.sleuth = {
  'tpope/vim-sleuth',
  event = { 'BufReadPre', 'BufNewFile' },
}

specs.readline = {
  'linty-org/readline.nvim',
  keys = k.readline,
}

specs.align = {
  'echasnovski/mini.align',
  opts = {},
  keys = {
    { mode = { 'x', 'n' }, 'ga' },
    { mode = { 'x', 'n' }, 'gA' },
  },
}

return u.values(specs)
