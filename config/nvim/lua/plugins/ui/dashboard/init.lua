--stylua: ignore
local header = require('plugins.ui.dashboard.parts.header')
local footer = require('plugins.ui.dashboard.parts.footer')
local body = require('plugins.ui.dashboard.parts.body')

local u = require('utils')

return {
  lazy = false,
  'goolord/alpha-nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = function()
    return {
      layout = u.join_tables({
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
