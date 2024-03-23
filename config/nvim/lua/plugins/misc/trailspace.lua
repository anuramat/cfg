-- Highlight trailing space
return {
  'echasnovski/mini.trailspace',
  event = 'VeryLazy',
  config = function()
    vim.api.nvim_create_user_command('Trim', require('mini.trailspace').trim, {})
    vim.cmd([[autocmd FileType lazy lua vim.b.minitrailspace_disable = true; require('mini.trailspace').unhighlight()]])
  end,
}
