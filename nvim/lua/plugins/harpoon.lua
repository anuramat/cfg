local specs = {}

local u = require("utils")
local k = require("config.keys")

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
