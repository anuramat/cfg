local u = require('utils')

--- Generates a banner
---@param text string
---@param font? string
---@return string
local function figlet(text, font)
  if not font then
    -- hehe
    local font_cmd =
      [[figlist | sed -n '/Figlet fonts in this directory:/,/Figlet control files in this directory:/{//!p}' | shuf | head -n 1]]
    local font_res = vim.system({ 'bash', '-c', font_cmd }, { text = true }):wait()
    font = u.trim(font_res.stdout)
  end
  vim.g.figlet_font = font
  local figlet_res = vim.system({ 'figlet', '-w', '999', '-f', font, text }, { text = true }):wait()
  return figlet_res.stdout
end

return figlet
