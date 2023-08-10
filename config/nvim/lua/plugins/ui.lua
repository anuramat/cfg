local specs = {}
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

return u.values(specs)
