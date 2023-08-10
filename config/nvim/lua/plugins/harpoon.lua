local specs = {}
local k = require('plugkeys')
local u = require('utils')

specs.harpoon = {
  'ThePrimeagen/harpoon',
  event = 'VeryLazy', -- load early cause tabline
  keys = k.harpoon(),
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = function()
    vim.cmd('highlight! HarpoonInactive guibg=NONE guifg=#63698c')
    vim.cmd('highlight! HarpoonActive guibg=NONE guifg=white')
    vim.cmd('highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7')
    vim.cmd('highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7')
    return { tabline = true }
  end,
}

return u.values(specs)
