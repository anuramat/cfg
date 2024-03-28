local hide = require('plugins.ui.dashboard.helpers').hide
local figlet = require('plugins.ui.dashboard.parts.body.figlet')
local footer = require('plugins.ui.dashboard.parts.footer')
local header = require('plugins.ui.dashboard.parts.header')
local u = require('utils')

local input = 'neovim'
local push_footer = true

local raw = figlet(input)
local height = #vim.split(raw, '\n', { trimempty = true }) -- TODO remove trimempty

--- Returns body text for the case of hidden banner
--- @param win_height integer
---@return string
local function just_pad(win_height)
  if hide(footer.output, header.height) then
    return ''
  end
  return u.repeat_string(' \n', win_height - header.height - footer.height)
end

--- Wraps output, centering it, and hiding it when it doesn't fit on the screen
---@return table elements
local elements = {
  {
    type = 'text',
    opts = { position = 'center' },
    val = function()
      local win_height = vim.fn.winheight(0)
      if hide(raw, header.height + footer.height) then
        return just_pad(win_height)
      end
      local top_padding = math.floor((win_height - height) / 2 - header.height)
      local bottom_padding = math.floor(win_height - header.height - top_padding - height - footer.height - 4)
      local output = u.repeat_string(' \n', top_padding) .. raw
      if push_footer then
        return output .. u.repeat_string(' \n', bottom_padding)
      end
      return output
    end,
  },
}

return {
  output = raw,
  height = height,
  elements = elements,
}
