--stylua: ignore
local header = require('plugins.ui.dashboard.parts.header')
local footer = require('plugins.ui.dashboard.parts.footer')(header.height)
local body = require('plugins.ui.dashboard.parts.body')(header.height, footer.height)

local u = require('utils')

return {
  lazy = false,
  'goolord/alpha-nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  init = require('plugins.ui.dashboard.hide_cursor'),
  opts = function()
    return {
      layout = u.join_tables({
        header.elements,
        body,
        footer.elements,
      }),
    }
  end,
}
