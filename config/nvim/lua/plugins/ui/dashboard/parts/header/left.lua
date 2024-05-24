local u = require('utils')
local used_keys = {}

local make_button = function(icon, name, cmd)
  local func = function()
    vim.cmd(cmd)
  end
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
  make_button('  󰈔 ', 'File', 'enew'),
  make_button('  󰅚 ', 'Quit', 'q'),
}

return {
  elements = elements,
  height = #elements,
}
