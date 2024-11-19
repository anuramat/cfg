local x_delim = '   '
local y_delim = ' \n \n'
local top_padding = 4 -- minimum 1
local bottom_padding = 4
assert(top_padding > 0, 'min padding is one because of the fake button')

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
}

local function grid_mapper(grid)
  return function()
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
end

local function render_text(grid)
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
  output = u.repeat_string(' \n', top_padding - 1) .. output .. u.repeat_string(' \n', bottom_padding)
  return output
end

local output = render_text(grid)
local height = #vim.split(output, '\n', { trim_empty = true })

vim.api.nvim_create_autocmd('Filetype', {
  pattern = { 'alpha' },
  callback = grid_mapper(grid),
})

return {
  elements = {
    { type = 'button', val = '█' }, -- HAHAHAHA HOLY FUCK
    {
      type = 'text',
      val = output,
      opts = { position = 'center' },
    },
  },
  height = height,
}
