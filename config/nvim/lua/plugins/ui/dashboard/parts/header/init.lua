local handlers = require('plugins.ui.dashboard.parts.header.handlers')

local make_button = function(icon, name, func)
  name = string.format('%-11s', name)
  local first = string.sub(name, 1, 1)
  return {
    type = 'button',
    val = icon .. string.upper(first) .. string.sub(name, 2),
    on_press = func,
    opts = {
      keymap = { 'n', string.lower(first), func },
      position = 'left',
      hl = 'AlphaButtons',
    },
  }
end

local elements = {
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

return {
  elements = elements,
  height = #elements,
}
