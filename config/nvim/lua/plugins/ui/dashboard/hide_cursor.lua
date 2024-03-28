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

return function()
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
