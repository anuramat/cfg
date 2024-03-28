return function(icon, name, func)
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
