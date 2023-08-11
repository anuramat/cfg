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

    vim.api.nvim_set_hl(0, 'HarpoonNumberActive', { fg = cs.purple, bg = cs.black })
    vim.api.nvim_set_hl(0, 'HarpoonActive', { fg = cs.purple, bg = cs.black })

    vim.api.nvim_set_hl(0, 'HarpoonNumberInactive', { fg = cs.fg, bg = cs.bg })
    vim.api.nvim_set_hl(0, 'HarpoonInactive', { fg = cs.fg, bg = cs.bg })

    return { tabline = true }
  end,
}

return u.values(specs)
