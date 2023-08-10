local specs = {}
local k = require('plug_keys')
local u = require('utils')

specs.dracula_cs = {
  'Mofiqul/dracula.nvim',
  priority = 1337,
  lazy = false,
  config = function()
    vim.cmd.colorscheme('dracula-soft')
    u.style_codelens()
  end,
}

specs.indentline = {
  'lukas-reineke/indent-blankline.nvim',
  event = 'VeryLazy',
  opts = {
    char = '│',
    filetype_exclude = {
      'TelescopePrompt',
      'Trouble',
      'checkhealth',
      'help',
      'lazy',
      'lspinfo',
      'man',
      'quickfix',
    },
    show_trailing_blankline_indent = false,
    show_current_context = false,
  },
}

specs.marks = {
  'chentoast/marks.nvim',
  event = 'VeryLazy',
  opts = {},
}

specs.todo = {
  'folke/todo-comments.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    highlight = {
      keyword = 'bg',
      -- TODO fix
      pattern = [[<(KEYWORDS)]], -- pattern or table of patterns, used for highlighting (vim regex)
    },
    search = {
      pattern = [[(KEYWORDS)]], -- ripgrep regex
    },
  },
}

specs.trouble = {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = k.trouble(),
}

return u.values(specs)
