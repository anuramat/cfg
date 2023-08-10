local specs = {}
local k = require('plug_keys')
local u = require('utils')

specs.surround = {
  'kylechui/nvim-surround',
  version = '*',
  opts = {},
  keys = {
    { '<C-g>s', mode = 'i' },
    { '<C-g>S', mode = 'i' },
    { 'ys' },
    { 'yS' },
    { 'S',      mode = 'x' },
    { 'gS',     mode = 'x' },
    { 'ds' },
    { 'cs' },
  }
}

specs.ai = {
  'echasnovski/mini.ai',
  keys = {
    { "a", mode = { "x", "o" } },
    { "i", mode = { "x", "o" } },
  },
  dependencies = { 'nvim-treesitter-textobjects' },
  opts = function()
    return {
      n_lines = 500,
      custom_textobjects = k.miniai(),
      silent = true,
    }
  end,
}

return u.values(specs)
