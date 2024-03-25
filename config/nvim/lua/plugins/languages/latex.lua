local function setup_commands()
  local sync = 'VimtexSync'
  local desync = 'VimtexDesync'

  local grname = 'VimtexSyncGroup'
  vim.api.nvim_create_user_command(sync, function()
    local group = vim.api.nvim_create_augroup(grname, {})
    vim.api.nvim_create_autocmd({ 'CursorMoved' }, {
      group = group,
      buffer = 0,
      callback = function()
        vim.cmd('VimtexView')
      end,
    })
  end, {})
  vim.api.nvim_create_user_command(desync, function()
    pcall(vim.api.nvim_del_augroup_by_name, grname)
  end, {})
end

return {
  {
    'lervag/vimtex',
    lazy = false, -- author swears it's lazy inside
    init = function()
      vim.cmd([[
      let g:vimtex_view_method = 'zathura'
      let g:vimtex_mappings_prefix = '<localleader>'
    ]])
    end,
    config = setup_commands(),
  },
}
