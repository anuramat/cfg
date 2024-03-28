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

-- wraps output, centering it vertically, and hiding it when it doesn't fit on the screen
return function(head_height, foot_height)
  return {
    {
      type = 'text',
      opts = { position = 'center' },
      val = function()
        local lines = vim.split(output, '\n')
        local line = lines[2]
        if #line > vim.fn.winwidth(0) then
          return ''
        end
        local win_height = vim.fn.winheight(0)
        local logo_height = #lines
        if head_height + logo_height + foot_height >= win_height then
          return ''
        end
        local logo_padding = math.floor((win_height - logo_height) / 2 - head_height)
        return u.repeat_string('\n ', logo_padding) .. output
      end,
    },
  }
end
