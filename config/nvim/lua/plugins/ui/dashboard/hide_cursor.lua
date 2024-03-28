local function hide_cursor()
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

local desc = 'Hide cursor in Alpha'
local ft = 'alpha'

return function()
  vim.api.nvim_create_autocmd({ 'Filetype' }, {
    pattern = ft,
    desc = desc,
    callback = hide_cursor,
  })

  vim.api.nvim_create_autocmd({ 'CmdlineEnter' }, {
    desc = desc,
    callback = function()
      unhide_cursor()
    end,
  })
  vim.api.nvim_create_autocmd({ 'CmdlineLeave', 'BufWinEnter' }, {
    desc = desc,
    callback = function()
      if vim.o.ft == ft then
        return hide_cursor()
      end
      unhide_cursor()
    end,
  })
end
