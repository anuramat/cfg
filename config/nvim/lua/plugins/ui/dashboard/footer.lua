local bottom_padding = 2
local min_top_padding = 2

local header = require('plugins.ui.dashboard.header')
local u = require('utils')

local info_string = function()
  local version = vim.version()
  local nvim_version_info = ' ' .. version.major .. '.' .. version.minor .. '.' .. version.patch
  return nvim_version_info
end

local output = u.repeat_string(' \n', min_top_padding) .. info_string() .. u.repeat_string(' \n', bottom_padding)
local lines = vim.split(output, '\n', { trimempty = true })
local height = #lines
local width = 0
for _, v in ipairs(lines) do
  if #v > width then
    width = #v
  end
end

local this = { height = height, hidden = false }
this.elements = {
  {
    type = 'text',
    val = function()
      local win_width = vim.fn.winwidth(0)
      local win_height = vim.fn.winheight(0)
      if width > win_width or height + header.height >= win_height then
        this.hidden = true
        return ''
      end
      this.hidden = false
      return output
    end,
    opts = { position = 'center' },
  },
}

return this
