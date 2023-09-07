local specs = {}
local u = require('utils')

specs.dracula_cs = {
  'Mofiqul/dracula.nvim',
  priority = 1337,
  lazy = false,
  config = function()
    local dracula = require('dracula')
    local cs = dracula.colors()
    local opts = {
      italic_comment = true,
      lualine_bg_color = cs.bg,
      transparent_bg = false,
    }
    dracula.setup(opts)

    vim.cmd.colorscheme('dracula')

    u.style_codelens()
    vim.cmd('highlight! link FloatBorder Normal')
    vim.cmd('highlight! link NormalFloat Normal')
    vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = 'none' })
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
  opts = { delay = 50 },
}

specs.which = {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 1000
  end,
  config = function()
    local wk = require('which-key')
    local opts = {
      operators = { gc = 'Comments', ys = 'Surround', ga = 'Align' },
      icons = {
        breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
        separator = '', -- symbol used between a key and it's label
        group = '+', -- symbol prepended to a group
      },
      triggers_nowait = {
        'z=',
      },
    } -- TODO fix
    local mappings = {
      ['<leader>b'] = { name = 'Buffer' },
      ['<leader>h'] = { name = 'Harpoon' },
      ['<leader>f'] = { name = 'Telescope' },
      ['<leader>l'] = { name = 'LSP' },
      ['<leader>lw'] = { name = 'LSP Workspace' }, -- fix ("+prefix" shows instead of "+LSP Workspace")
      ['<leader>d'] = { name = 'DAP' },
      ['<leader>t'] = { name = 'Trouble' },
      ['<leader>g'] = { name = 'Git' },
      ['<leader>q'] = { name = 'Quickfix' },
    }
    wk.register(mappings)
    wk.setup(opts)
  end,
}

specs.zen = {
  'folke/zen-mode.nvim',
  event = 'VeryLazy',
  opts = {
    window = {
      backdrop = 1,
      width = 120,
      height = 1,
      options = {},
    },
    plugins = {
      options = {
        enabled = true,
        ruler = false,
        showcmd = false,
      },
      gitsigns = { enabled = true }, -- hide gitsigns
      tmux = { enabled = true }, -- hide tmux bar WARNING can hide bar until tmux restart
    },
  },
}

specs.fidget = {
  'j-hui/fidget.nvim',
  tag = 'legacy',
  event = 'LspAttach',
  opts = {},
}

return u.values(specs)
