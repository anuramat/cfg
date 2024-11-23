local input = 'neovim'
local push_footer = true
local u = require('utils')

local footer = require('plugins.ui.dashboard.footer')
local header = require('plugins.ui.dashboard.header')

local raw = u.figlet(input)
local lines = vim.split(raw, '\n', { trimempty = true })
local height = #lines
local width = 0
for _, v in ipairs(lines) do
  if #v > width then
    width = #v
  end
end

--- Returns body text for the case of hidden banner
--- @param win_height integer
---@return string
local function just_pad(win_height)
  if footer.hidden then
    return ''
  end
  return string.rep(' \n', win_height - header.height - footer.height)
end

--- Wraps output, centering it, and hiding it when it doesn't fit on the screen
---@return table elements
local elements = {
  {
    type = 'text',
    opts = { position = 'center' },
    val = function()
      local win_height = vim.fn.winheight(0)
      local win_width = vim.fn.winwidth(0)
      if width > win_width then
        return just_pad(win_height)
      end
      local top_adaptive_padding = math.max(math.floor((win_height - height) / 2 - header.height), 0)
      local bottom_adaptive_padding =
        math.max(win_height - header.height - top_adaptive_padding - height - footer.height, 0)
      local output = string.rep(' \n', top_adaptive_padding) .. raw
      if push_footer then
        output = output .. string.rep(' \n', bottom_adaptive_padding)
      end
      local real_lines = vim.split(output, '\n', { trimempty = true })
      if #real_lines + footer.height + header.height > win_height then
        return just_pad(win_height)
      end
      return output
    end,
  },
}

return {
  height = height,
  elements = elements,
}
