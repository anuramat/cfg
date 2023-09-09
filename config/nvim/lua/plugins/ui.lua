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
      operators = { -- XXX keep this up to date
        ['<leader>c'] = 'Comment',
        ['<leader>s'] = 'Surround',
        ['<leader>a'] = 'Align',
        ['<leader>A'] = 'Align',
      },
      key_labels = {
        ['<leader>'] = 'LDR',
        ['<space>'] = 'SPC',
        ['<cr>'] = 'RET',
        ['<tab>'] = 'TAB',
        ['<esc>'] = 'ESC',
        ['<bs>'] = 'BSP', -- BUG doesn't change "up"/"close" binding label
      },
      icons = {
        breadcrumb = '', -- cmdline: shows active combo
        separator = '', -- used between a key and its label
        group = '+', -- symbol prepended to a group
      },
      triggers_nowait = {
        'z=',
      },
    }
    local mappings = {
      mode = { 'n' },
      ['<leader>'] = { -- XXX keep this up to date
        b = 'Buffer',
        h = 'Harpoon',
        f = 'Telescope',
        l = { name = 'LSP', w = 'Workspace' },
        d = 'DAP',
        t = 'Trouble',
        g = 'Git',
        s = 'Language specific hotkeys',
      },
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
      width = 1,
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
      kitty = { -- TODO change increment
        enabled = false,
        font = '+4', -- font size increment
      },
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
