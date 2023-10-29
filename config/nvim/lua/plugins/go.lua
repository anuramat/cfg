local specs = {}
local u = require('utils')

specs.go = {
  'ray-x/go.nvim',
  dependencies = { -- optional packages
    'ray-x/guihua.lua',
    'neovim/nvim-lspconfig',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('go').setup({ diagnostic = { hdlr = false } })
  end,
  event = { 'CmdlineEnter' },
  ft = { 'go', 'gomod' },
  -- build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
}

return u.values(specs)
