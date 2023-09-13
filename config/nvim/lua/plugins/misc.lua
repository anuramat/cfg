local specs = {}
local u = require('utils')

specs.undotree = {
  'mbbill/undotree',
  cmd = {
    'UndotreeHide',
    'UndotreeShow',
    'UndotreeFocus',
    'UndotreeToggle',
  },
  keys = {
    {
      '<leader>u',
      '<cmd>UndotreeToggle<cr>',
      desc = 'Undotree',
    },
  },
}

specs.sleuth = {
  'tpope/vim-sleuth',
  event = { 'BufReadPre', 'BufNewFile' },
}

specs.align = {
  'echasnovski/mini.align',
  version = false,
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

specs.trailspace = {
  'echasnovski/mini.trailspace',
  version = false,
  event = 'VeryLazy',
  opts = function()
    vim.api.nvim_create_user_command('TrimTrailingWhitespace', require('mini.trailspace').trim, {})
    return {}
  end,
}

specs.dadbod = {
  'tpope/vim-dadbod',
  lazy = false,
}

specs.dadbod_ui = {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = { 'tpope/vim-dadbod' },
  lazy = false,
}

specs.marks = {
  'chentoast/marks.nvim',
  event = 'VeryLazy',
  opts = {
    default_mappings = false,
    builtin_marks = {},
  },
  keys = {
    { 'dm', '<Plug>(Marks-delete)', desc = 'Delete mark' },
    { 'dm-', '<Plug>(Marks-deleteline)', desc = 'Delete all marks on the current line' },
    { 'dm=', '<Plug>(Marks-deletebuf)', 'Delete all marks in the current buffer' },
  },
}

return u.values(specs)
