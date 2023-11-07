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
      transparent_bg = true,
    }
    dracula.setup(opts)

    vim.cmd.colorscheme('dracula')

    -- Override shitty default CodeLens style
    local clhl = vim.api.nvim_get_hl(0, { name = 'LspCodeLens' })
    clhl.standout = true
    vim.api.nvim_set_hl(0, 'LspCodeLens', clhl)

    -- TODO what the fuck does this do
    vim.cmd('highlight! link FloatBorder Normal')
    vim.cmd('highlight! link NormalFloat Normal')

    -- Make window borders properly visible
    vim.cmd('hi WinSeparator guibg=bg guifg=fg')

    -- Make Telescope have proper background
    vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = 'none' })
  end,
}

specs.indentline = {
  'lukas-reineke/indent-blankline.nvim',
  event = 'VeryLazy',
  main = 'ibl',
  opts = {
    exclude = {
      filetypes = {
        'Trouble',
        'lazy',
      },
    },
    indent = { char = '│' },
    scope = {
      enabled = true,
      show_start = false,
      show_end = false,
    },
  },
}

specs.cursorword = {
  'echasnovski/mini.cursorword',
  version = false,
  event = 'VeryLazy',
  opts = { delay = 0 },
}

specs.zen = {
  'folke/zen-mode.nvim',
  cmd = 'ZenMode',
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
      tmux = { enabled = true }, -- hide tmux bar BUG can hide bar until tmux restart, careful
    },
  },
}

specs.fidget = {
  'j-hui/fidget.nvim',
  tag = 'legacy',
  event = 'LspAttach',
  opts = {
    window = { blend = 0 }, -- fixes black background on transparent theme
  },
}

specs.clue = {
  'echasnovski/mini.clue',
  event = 'VeryLazy',
  config = function()
    local miniclue = require('mini.clue')
    miniclue.setup({
      triggers = {
        -- Leader triggers
        { mode = 'n', keys = '<Leader>' },
        { mode = 'x', keys = '<Leader>' },

        -- Built-in completion
        { mode = 'i', keys = '<C-x>' },

        -- `g` key
        { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' },

        -- Marks
        { mode = 'n', keys = '\'' },
        { mode = 'n', keys = '`' },
        { mode = 'x', keys = '\'' },
        { mode = 'x', keys = '`' },

        -- Registers
        { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' },
        { mode = 'i', keys = '<C-r>' },
        { mode = 'c', keys = '<C-r>' },

        -- Window commands
        { mode = 'n', keys = '<C-w>' },

        -- `z` key
        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = 'z' },

        -- [/]
        { mode = 'n', keys = ']' },
        { mode = 'n', keys = '[' },

        -- Operators
        { mode = 'n', keys = 'c' },
        { mode = 'n', keys = 'd' },
      },

      clues = {
        -- ~~~~~~~~~~~~~~~~~~~~ Vim ~~~~~~~~~~~~~~~~~~~~~ --
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
        -- ~~~~~~~~~~~~~~~~~~~ Custom ~~~~~~~~~~~~~~~~~~~ --
        { mode = 'n', keys = '<Leader>d', desc = '+Debug' },
        { mode = 'v', keys = '<Leader>d', desc = '+Debug' },

        { mode = 'n', keys = '<Leader>f', desc = '+Telescope' },
        { mode = 'n', keys = '<Leader>g', desc = '+Git' },
        { mode = 'n', keys = '<Leader>h', desc = '+Harpoon' },
        { mode = 'n', keys = '<Leader>l', desc = '+LSP' },
        { mode = 'n', keys = '<Leader>t', desc = '+Trouble' },
        -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
      },
      window = {
        delay = 0,
        config = {
          width = 'auto',
        },
      },
    })
  end,
}

return u.values(specs)
