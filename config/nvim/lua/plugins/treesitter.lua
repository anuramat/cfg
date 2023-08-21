local specs = {}
local k = require('plugkeys')
local u = require('utils')

local langs = {
  'bash',
  'c',
  'go',
  'gomod',
  'gosum',
  'gowork',
  'haskell',
  'json',
  'lua',
  'luadoc',
  'luap',
  'markdown',
  'markdown_inline',
  'python',
  'query',
  'regex',
  'sql',
  'vim',
  'vimdoc',
  'yaml',
}

specs.treesitter = {
  'nvim-treesitter/nvim-treesitter',
  version = false, -- last release is way too old
  build = ':TSUpdate',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  opts = {
    highlight = { enable = true, disable = { 'markdown' } },
    indent = { enable = true }, -- noexpandtab is broken with python
    ensure_installed = langs,
    incremental_selection = {
      enable = true,
      keymaps = k.treesitter.inc_selection,
    },
    textobjects = {
      swap = u.merge({ enable = true }, k.treesitter.textobj_swap),
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false, -- Comment.nvim takes care of this
    },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
    vim.o.foldmethod = 'expr'
    vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
  end,
}

return u.values(specs)
