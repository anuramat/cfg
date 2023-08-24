local specs = {}
local u = require('utils')

specs.dracula_cs = {
  'Mofiqul/dracula.nvim',
  priority = 1337,
  lazy = false,
  config = function()
    local dracula = require('dracula')
    local cs = dracula.colors()
    dracula.setup({
      italic_comment = true,
      lualine_bg_color = cs.bg,
      transparent_bg = true, -- default false
    })
    vim.cmd.colorscheme('dracula')
    u.style_codelens()

    vim.cmd('highlight! link FloatBorder Normal')
    vim.cmd('highlight! link NormalFloat Normal')
    vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = 'none' })
    -- TODO white border on telescope? or grey on harpoon?
    -- maybe new theme telescope?
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

specs.cursorword = {
  'echasnovski/mini.cursorword',
  version = false,
  event = 'VeryLazy', -- TODO lazier?
}

return u.values(specs)
