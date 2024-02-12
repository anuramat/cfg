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

-- Highlight trailing space
-- Could be replaced with a few lines of code tbh
specs.trailspace = {
  'echasnovski/mini.trailspace',
  version = false,
  event = 'VeryLazy',
  opts = function()
    vim.api.nvim_create_user_command('TrimTrailingWhitespace', require('mini.trailspace').trim, {})
    return {}
  end,
}

-- Databases
specs.dadbod_ui = {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
  end,
}

-- File manager
specs.oil = {
  'stevearc/oil.nvim',
  -- event = 'VeryLazy',
  lazy = false, -- so that it overrides "nvim <path>"
  opts = {},
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '<leader>o', '<cmd>Oil<cr>', desc = 'File Manager (Oil)' },
  },
}

-- File tree
specs.tree = {
  'nvim-tree/nvim-tree.lua',
  opts = {},
  keys = {
    { '<leader>t', '<cmd>NvimTreeToggle<cr>', desc = 'File Tree (NvimTree)' },
  },
}

-- File management commands (rename, remove, chmod...)
-- Must have
-- see also:
-- chrisgrieser/nvim-genghis - drop in lua replacement with some bloat/improvements
specs.eunuch = {
  'tpope/vim-eunuch',
  event = 'VeryLazy',
}

-- -- unusable until we get a blacklist regex for .pb.go files
-- specs.symbols = {
--   'Wansmer/symbol-usage.nvim',
--   event = 'BufReadPre', -- NOTE need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
--   opts = {
--     vt_position = 'end_of_line',
--   },
-- }

return u.values(specs)
