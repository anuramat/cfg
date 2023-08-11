local specs = {}
local k = require('plugkeys')
local u = require('utils')

specs.harpoon = {
  'ThePrimeagen/harpoon',
  event = 'VeryLazy', -- load early cause tabline
  keys = k.harpoon(),
  dependencies = {
    'nvim-lua/plenary.nvim',
    'Mofiqul/dracula.nvim',
  },
  opts = function()
    local cs = require('dracula').colors()
    local on = { fg = cs.black, bg = cs.purple, bold = true }
    local off = { fg = cs.fg, bg = cs.visual, bold = true }

    vim.api.nvim_set_hl(0, 'HarpoonNumberActive', on)
    vim.api.nvim_set_hl(0, 'HarpoonActive', on)

    vim.api.nvim_set_hl(0, 'HarpoonNumberInactive', off)
    vim.api.nvim_set_hl(0, 'HarpoonInactive', off)

    vim.api.nvim_set_hl(0, 'TabLineFill', {})

    return {
      tabline_prefix = ' ',
      tabline_suffix = ' ',
      menu = {
        width = 80,
      },
    }
  end,
}

return u.values(specs)
