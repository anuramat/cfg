local function hide_cursor()
  vim.print('asdf')
  local hl = vim.api.nvim_get_hl_by_name('Cursor', true)
  hl.blend = 100
  vim.api.nvim_set_hl(0, 'Cursor', hl)
  vim.opt.guicursor:append('a:Cursor/lCursor')
end
local function unhide_cursor()
  local hl = vim.api.nvim_get_hl_by_name('Cursor', true)
  hl.blend = 0
  vim.api.nvim_set_hl(0, 'Cursor', hl)
  vim.opt.guicursor:remove('a:Cursor/lCursor')
end

local set_cursor_hiding = function()
  vim.api.nvim_create_autocmd({ 'Filetype' }, {
    pattern = { 'alpha' },
    desc = 'hide cursor for alpha',
    callback = hide_cursor,
  })
  vim.api.nvim_create_autocmd('BufUnload', {
    buffer = 0, -- TODO how does this work
    desc = 'show cursor after alpha',
    callback = unhide_cursor,
  })
end

local handlers = require('plugins.ui.dashboard.handlers')

local headers = {
  info = function()
    local datetime = os.date(' %d-%m-%Y   %H:%M:%S')
    local version = vim.version()
    local nvim_version_info = ' ' .. version.major .. '.' .. version.minor .. '.' .. version.patch
    return datetime .. '   ' .. nvim_version_info
  end,
}

local function make_button(icon, name, func)
  name = string.format('%-11s', name)
  local first = string.sub(name, 1, 1)
  return {
    type = 'button',
    val = icon .. ' ' .. string.upper(first) .. string.sub(name, 2),
    on_press = func,
    opts = {
      keymap = { 'n', string.lower(first), func },
      position = 'left',
      hl = 'AlphaButtons',
    },
  }
end

return {
  lazy = false,
  'goolord/alpha-nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    layout = {
      make_button('󰈔', 'scratch', handlers.new_file),
      make_button('󰷉', 'note', handlers.obsidian_new),
      make_button('󰃶', 'today', handlers.obsidian_today),
      make_button('󱌣', 'config', handlers.configs),
      make_button('󰥨', 'open', handlers.find),
      make_button('󰱽', 'grep', handlers.grep),
      make_button('󰉋', 'jump', handlers.jump),
      make_button('󰅚', 'quit', handlers.quit),
      { type = 'text', val = headers.info, opts = { position = 'center' } },
      { type = 'padding', val = 3 },
      { type = 'text', val = require('plugins.ui.dashboard.logo'), opts = { position = 'center' } },
    },
  },
}
