local specs = {}
local u = require('utils')

-- Autodetect indentation settings
specs.sleuth = {
  'tpope/vim-sleuth',
  event = { 'BufReadPre', 'BufNewFile' },
}

-- Highlight trailing space
specs.trailspace = {
  'echasnovski/mini.trailspace',
  event = 'VeryLazy',
  config = function()
    vim.api.nvim_create_user_command('Trim', require('mini.trailspace').trim, {})
    vim.cmd([[autocmd FileType lazy lua vim.b.minitrailspace_disable = true; require('mini.trailspace').unhighlight()]])
  end,
}

-- File management commands (rename, remove, chmod...)
-- Must have
-- see also:
-- chrisgrieser/nvim-genghis - drop in lua replacement with some bloat/improvements
specs.eunuch = {
  'tpope/vim-eunuch',
  event = 'VeryLazy',
}

return u.values(specs)
