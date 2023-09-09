local specs = {}
local k = require('plugkeys')
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
    { 'S', mode = 'x' },
    { 'gS', mode = 'x' },
    { 'ds' },
    { 'cs' },
  },
}

specs.ai = {
  'echasnovski/mini.ai',
  version = false,
  keys = {
    { 'a', mode = { 'x', 'o' } },
    { 'i', mode = { 'x', 'o' } },
  },
  dependencies = { 'nvim-treesitter-textobjects' },
  opts = function()
    local ts = require('mini.ai').gen_spec.treesitter
    return {
      n_lines = 500,
      custom_textobjects = {
        b = false, -- = ([{
        q = false, -- = `'"
        -- ~~~~~~~~~~~~~~~~~~~ functions ~~~~~~~~~~~~~~~~~~~ --
        F = ts({
          a = { '@function.outer' },
          i = { '@function.inner' },
        }, {}),
        f = ts({
          a = { '@call.outer' },
          i = { '@call.inner' },
        }),
        a = ts({
          a = { '@parameter.outer' },
          i = { '@parameter.inner' },
        }),
        -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
        e = ts({
          a = { '@assignment.outer' },
          i = { '@assignment.rhs' },
        }),
        r = ts({
          a = { '@return.outer' },
          i = { '@return.inner' },
        }),
        -- ~~~~~~~~~~~~~~~~~~~~~ misc ~~~~~~~~~~~~~~~~~~~~~~ --
        s = ts({ -- structs/classes; instance/definition
          a = { '@class.outer' },
          i = { '@class.inner' },
        }, {}),
        c = ts({ -- inner doesn't work with most languages, use outer
          a = { '@comment.outer' },
          i = { '@comment.inner' },
        }),
        o = ts({ -- any other blocks
          a = { '@block.outer', '@conditional.outer', '@loop.outer', '@frame.outer' },
          i = { '@block.inner', '@conditional.inner', '@loop.inner', '@frame.inner' },
        }, {}),
      },
      silent = true,
    }
  end,
}

return u.values(specs)
