local hide = require('plugins.ui.dashboard.helpers').hide
local u = require('utils')

local function figlet(text, font)
  local font_fmt = [[figlet -f '%s' '%s']]
  local font_cmd = string.format(font_fmt, font, text)
  local font_list = vim.system({ 'bash', '-c', font_cmd }, { text = true }):wait()
  return font_list.stdout
end

local function random_figlet(text)
  local font_fmt =
    [[figlist | sed -n '/Figlet fonts in this directory:/,/Figlet control files in this directory:/{//!p}' | shuf | head -n 1 | xargs -I{} sh -c 'echo font:{}; figlet -f {} "%s"']]
  local font_cmd = string.format(font_fmt, text)
  local font_list = vim.system({ 'bash', '-c', font_cmd }, { text = true }):wait()
  return font_list.stdout
end

local input = 'neovim'
local output = random_figlet(input)

-- wraps output, centering it, and hiding it when it doesn't fit on the screen
return function(header_height, footer_height, push_footer)
  return {
    {
      type = 'text',
      opts = { position = 'center' },
      val = function()
        local height = #vim.split(output, '\n', { trimempty = true })
        local win_height = vim.fn.winheight(0)
        if hide(output, header_height + footer_height) then
          return ''
        end
        local half_complement = (win_height - height) / 2
        local top_padding = math.floor(half_complement - header_height)
        output = u.repeat_string(' \n', top_padding) .. output
        if true then
          local bottom_padding = math.floor(half_complement - footer_height)
          return output .. u.repeat_string(' \n', bottom_padding)
        end
        return output
      end,
    },
  }
end
