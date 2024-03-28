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

return function()
  local lines = vim.split(output, '\n')
  local line = lines[2]
  local win = vim.api.nvim_get_current_win()
  if #line > vim.fn.winwidth(win) then
    return ''
  end
  return output
end
