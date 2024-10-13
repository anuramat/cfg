--stylua: ignore
local header = require('plugins.misc.dashboard.header')
local footer = require('plugins.misc.dashboard.footer')
local body = require('plugins.misc.dashboard.body')

local u = require('utils')

return {
  lazy = false,
  'goolord/alpha-nvim',
  event = 'VimEnter',
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
