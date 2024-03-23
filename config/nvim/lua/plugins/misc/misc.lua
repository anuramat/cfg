local specs = {}
local u = require('utils')

-- Autodetect indentation settings
specs.sleuth = {
  'tpope/vim-sleuth',
  event = { 'BufReadPre', 'BufNewFile' },
}

-- Align text interactively
-- See also:
-- junegunn/vim-easy-align
-- godlygeek/tabular
-- tommcdo/vim-lion
-- Vonr/align.nvim
specs.align = {
  'echasnovski/mini.align',
  opts = {
    mappings = {
      start = '<leader>a',
      start_with_preview = '<leader>A',
    },
  },
  keys = {
    { mode = { 'x', 'n' }, '<leader>a', desc = 'Align' },
    { mode = { 'x', 'n' }, '<leader>A', desc = 'Interactive align' },
  },
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
