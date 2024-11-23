local u = require('utils')

local input = 'neovim'

local raw = u.figlet(input)
local lines = vim.split(raw, '\n', { trimempty = true })
local tx = #lines[1] -- assuming all lines have equal width
local ty = #lines
local ver_string = u.version_string()
ver_string = string.rep(' ', math.floor((tx - #ver_string) / 2)) .. ver_string
local spacing = 3
raw = raw .. string.rep(' \n', spacing) .. ver_string
ty = ty + spacing -- +1 from ver string, -1 from button

--- Wraps output, centering it, and hiding it when it doesn't fit on the screen
---@return table elements
local body = {
  type = 'text',
  opts = { position = 'center' },
  val = function()
    local wx = vim.fn.winwidth(0)
    local wy = vim.fn.winheight(0)

    local xpad = math.floor((wx - tx) / 2)
    local ypad = math.floor((wy - ty) / 2)

    if xpad <= 0 or ypad <= 0 then
      return ''
    end

    vim.print(ypad)
    return string.rep(' \n', ypad) .. raw
  end,
}

return {
  lazy = false,
  'goolord/alpha-nvim',
  event = 'VimEnter',
  -- enabled = false,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = function()
    return {
      layout = {
        { type = 'button', val = '█' }, -- hides cursor
        body,
      },
      opts = {
        keymap = {
          press = nil,
          press_queue = nil,
        },
      },
    }
  end,
}
