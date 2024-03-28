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
    local head = {
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
    local foot_padding = 3
    local foot = {
      { type = 'padding', val = foot_padding },
      { type = 'text', val = info_string, opts = { position = 'center' } },
    }
    local logo = require('plugins.ui.dashboard.logo')(#head, 1 + foot_padding)
    return {
      layout = u.join_tables({
        head,
        logo,
        foot,
      }),
    }
  end,
}
