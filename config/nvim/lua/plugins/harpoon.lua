local specs = {}
local k = require('plug_keys')
local u = require('utils')

specs.harpoon = {
  'ThePrimeagen/harpoon',
  keys = k.harpoon(),
  dependencies = {
    'nvim-lua/plenary.nvim', },
  opts = {
    --   tabline = true
  }
}

return u.values(specs)
