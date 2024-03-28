local u = require('utils')

---@class button
---@field icon string
---@field name string
---@field command string

local grid ---@type button[][]
grid = {
  {
    { icon = '󰈔 ', name = 'File', command = 'enew' },
    { icon = '󰅚 ', name = 'Quit', command = 'q' },
  },
  {
    { icon = '󰷉 ', name = 'Note', command = 'ObsidianNew' },
    { icon = '󰃶 ', name = 'Tday', command = 'ObsidianToday' },
  },
}

local function map_grid()
  local used_keys = {}
  for _, row in ipairs(grid) do
    for _, button in ipairs(row) do
      local key = string.lower(string.sub(button.name, 1, 1))
      -- make sure we don't map to the same key twice
      if u.contains(used_keys, key) then
        error('dashboard keymap collision')
      end
      table.insert(used_keys, key)
      vim.api.nvim_buf_set_keymap(0, 'n', key, '<cmd>' .. button.command .. '<cr>', {})
    end
  end
end

local x_delim = '   '
local y_delim = '\n'
local top_padding = 2
local bottom_padding = 2 -- minimum 1
assert(bottom_padding > 0, 'min padding is one because of the fake button')

local function render_text()
  map_grid()

  local lines = {}
  for i = 1, #grid do
    local row = grid[i]
    local line = ''
    for j = 1, #row do
      local button = row[j]
      line = line .. button.icon .. button.name
      if j ~= #row then
        line = line .. x_delim
      end
    end
    table.insert(lines, line)
  end
  local output = vim.iter(lines):join(y_delim)
  output = u.repeat_string('\n', top_padding) .. output .. u.repeat_string('\n', bottom_padding - 1)
  return output
end

local output = render_text()
local height = #vim.split(output, '\n')

return {
  elements = {
    { type = 'button', val = '' },
    {
      type = 'text',
      val = function()
        map_grid()
        return output
      end,
      opts = { position = 'center' },
    },
  },
  height = height,
}
