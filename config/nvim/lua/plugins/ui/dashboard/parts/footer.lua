local hide = require('plugins.ui.dashboard.helpers').hide
local u = require('utils')

local info_string = function()
  local version = vim.version()
  local nvim_version_info = ' ' .. version.major .. '.' .. version.minor .. '.' .. version.patch
  return nvim_version_info
end

local output = info_string()

local padding = 2

return function(header_height)
  return {
    elements = {
      {
        type = 'text',
        val = function()
          if hide(output, header_height) then
            return ''
          end
          return output .. u.repeat_string(' \n', padding)
        end,
        opts = { position = 'center' },
      },
    },
    height = padding + 1,
  }
end
