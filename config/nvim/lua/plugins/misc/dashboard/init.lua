local body = require('plugins.misc.dashboard.body')
local footer = require('plugins.misc.dashboard.footer')
local header = require('plugins.misc.dashboard.header')

local u = require('utils')

return {
  lazy = false,
  'goolord/alpha-nvim',
  event = 'VimEnter',
  -- enabled = false,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = function()
    return {
      layout = u.join_list({
        header.elements,
        body.elements,
        footer.elements,
      }),
      opts = {
        keymap = {
          press = nil,
          press_queue = nil,
        },
      },
    }
  end,
}
