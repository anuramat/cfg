local handlers = require('plugins.ui.dashboard.handlers')
local info_string = require('plugins.ui.dashboard.info_string')
local make_button = require('plugins.ui.dashboard.make_button')
local u = require('utils')

return {
  lazy = false,
  'goolord/alpha-nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  init = require('plugins.ui.dashboard.hide_cursor'),
  opts = function()
    local layout = {
      make_button(' 󰈔 ', 'scratch', handlers.new_file),
      make_button(' 󰷉 ', 'note', handlers.obsidian_new),
      make_button(' 󰃶 ', 'today', handlers.obsidian_today),
      make_button(' 󱌣 ', 'config', handlers.configs),
      make_button(' 󰥨 ', 'open', handlers.find),
      make_button(' 󰱽 ', 'grep', handlers.grep),
      make_button(' 󰉋 ', 'jump', handlers.jump),
      make_button(' 󰅚 ', 'quit', handlers.quit),
      make_button(' 󰉹 ', 'recent', handlers.mru),
    }
    local win_height = vim.fn.winheight(0)
    local logo, logo_height = require('plugins.ui.dashboard.logo')()
    local logo_padding = math.floor((win_height - logo_height) / 2 - #layout)
    return {
      layout = u.join(layout, {
        { type = 'padding', val = logo_padding },
        { type = 'text', val = logo, opts = { position = 'center' } },
        { type = 'padding', val = 3 },
        { type = 'text', val = info_string, opts = { position = 'center' } },
      }),
      keymap = { press = nil },
    }
  end,
}
