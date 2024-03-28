local handlers = require('plugins.ui.dashboard.handlers')
local header = require('plugins.ui.dashboard.header')
local make_button = require('plugins.ui.dashboard.make_button')

return {
  lazy = false,
  'goolord/alpha-nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  init = require('plugins.ui.dashboard.hide_cursor'),
  opts = {
    layout = {
      make_button('󰈔', 'scratch', handlers.new_file),
      make_button('󰷉', 'note', handlers.obsidian_new),
      make_button('󰃶', 'today', handlers.obsidian_today),
      make_button('󱌣', 'config', handlers.configs),
      make_button('󰥨', 'open', handlers.find),
      make_button('󰱽', 'grep', handlers.grep),
      make_button('󰉋', 'jump', handlers.jump),
      make_button('󰅚', 'quit', handlers.quit),
      { type = 'text', val = header.info, opts = { position = 'center' } },
      { type = 'padding', val = 3 },
      { type = 'text', val = require('plugins.ui.dashboard.logo'), opts = { position = 'center' } },
    },
  },
}
