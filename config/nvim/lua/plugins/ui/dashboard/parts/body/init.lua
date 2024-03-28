local hide = require('plugins.ui.dashboard.helpers').hide
local figlet = require('plugins.ui.dashboard.parts.body.figlet')
local footer = require('plugins.ui.dashboard.parts.footer')
local header = require('plugins.ui.dashboard.parts.header')
local u = require('utils')

local input = 'neovim'

local output = figlet(input)
local height = #vim.split(output, '\n', { trimempty = true })

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
---@param header_height integer
---@param footer_height integer
---@param push_footer boolean Align the footer to the bottom
---@return table elements
local function wrapped_elements(header_height, footer_height, push_footer)
  return {
    {
      type = 'text',
      opts = { position = 'center' },
      val = function()
        local win_height = vim.fn.winheight(0)
        if hide(output, header_height + footer_height) then
          return just_pad(win_height)
        end
        local half_complement = (win_height - height) / 2
        local top_padding = math.floor(half_complement - header_height)
        output = u.repeat_string(' \n', top_padding) .. output
        if push_footer then
          local bottom_padding = math.floor(half_complement - footer_height)
          return output .. u.repeat_string(' \n', bottom_padding)
        end
        return output
      end,
    },
  }
end

return {
  output = output,
  height = height,
  wrapped_elements = wrapped_elements,
}
