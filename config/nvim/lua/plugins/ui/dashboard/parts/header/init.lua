local handlers = require('plugins.ui.dashboard.parts.header.handlers')
local u = require('utils')

local used_keys = {}

local make_button = function(icon, name, func)
  local key = string.lower(string.sub(name, 1, 1))
  if u.contains(used_keys, key) then
    error('dashboard keymap collision')
  end
  table.insert(used_keys, key)
  return {
    type = 'button',
    val = icon .. name,
    on_press = func,
    opts = {
      keymap = { 'n', key, func },
      position = 'left',
      hl = 'AlphaButtons',
    },
  }
end

local elements = {
  { type = 'padding', val = 1 },
  make_button('  󰈔 ', 'File', handlers.new_file),
  make_button('  󰉹 ', 'Rcnt', handlers.mru),
  make_button('  󰅚 ', 'Quit', handlers.quit),
  { type = 'padding', val = 1 },
  make_button('  󰥨 ', 'Open', handlers.find),
  make_button('  󰱽 ', 'Grep', handlers.grep),
  make_button('  󰉋 ', 'Jump', handlers.jump),
  { type = 'padding', val = 1 },
  make_button('  󰷉 ', 'Note', handlers.obsidian_new),
  make_button('  󰃶 ', 'Tday', handlers.obsidian_today),
  make_button('  󱌣 ', 'Pref', handlers.neovim_config_find),
}

return {
  elements = elements,
  height = #elements,
}
