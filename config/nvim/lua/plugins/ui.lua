local specs = {}
local u = require('utils')

-- dracula colorscheme
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
    -- Override shitty default CodeLens style
    local clhl = vim.api.nvim_get_hl(0, { name = 'LspCodeLens' })
    clhl.underline = true
    clhl.bold = true
    vim.api.nvim_set_hl(0, 'LspCodeLens', clhl)
    -- Make window borders properly visible
    vim.cmd('hi WinSeparator guibg=bg guifg=fg')
  end,
}

-- show indent line
--  - on blank lines
--  - with expandtab
specs.indentline = {
  'lukas-reineke/indent-blankline.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  event = 'VeryLazy',
  main = 'ibl',
  init = function()
    vim.cmd([[se lcs+=lead:\ ]])
  end,
  opts = {
    exclude = {
      filetypes = {
        'lazy',
      },
    },
    indent = {
      -- char = '│',
      char = '┃',
    },
    scope = {
      enabled = true,
      show_start = false,
      show_end = false,
    },
  },
}

-- -- lsp progress overlay
-- -- can fuck up on LspDetach with multiple lsps when closing
-- specs.fidget = {
--   'j-hui/fidget.nvim',
--   event = 'LspAttach',
--   opts = {},
-- }

-- custom
--  - messages
--  - cmdline
--  - popupmenu
specs.noice = {
  'folke/noice.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
    'Mofiqul/dracula.nvim',
    'hrsh7th/nvim-cmp',
  },
  event = 'VeryLazy',
  opts = function()
    require('notify').setup({
      background_colour = require('dracula').colors().bg,
      render = 'wrapped-compact',
      on_open = function(win)
        -- set notify border
        if vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_win_set_config(win, { border = vim.g.border })
        end
      end,
    })
    return {
      cmdline = { format = { help = false } },
      presets = {
        command_palette = true, -- position the cmdline and popupmenu together
        bottom_search = true, -- use a classic bottom cmdline for search
        long_message_to_split = true, -- long messages will be sent to a split
      },
      lsp = {
        signature = { enabled = false }, -- off because we use ray-x/lsp_signature.nvim
        hover = { enabled = true },
        documentation = { opts = { border = vim.g.border } },
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp and other two options
        },
      },
      messages = {
        view_search = 'cmdline',
        enabled = false, -- moves messages back to cmdline
      },
    }
  end,
}

-- custom
--  - vim.ui.select - picker
--  - vim.ui.input - a text field
specs.dressing = {
  'stevearc/dressing.nvim',
  opts = {
    input = {
      enabled = false,
    },
  },
  event = 'VeryLazy',
}

-- adds animation to scrolling, resizing and cursor movement
specs.animate = {
  'echasnovski/mini.animate',
  version = '*',
  event = 'VeryLazy',
  config = function()
    if vim.g.neovide then
      return
    end
    local animate = require('mini.animate')
    animate.setup({
      cursor = {
        timing = animate.gen_timing.exponential({ duration = 100, unit = 'total' }),
      },
      scroll = {
        timing = animate.gen_timing.exponential({ duration = 100, unit = 'total' }),
      },
      resize = {
        -- enable = false, -- resize animation soft-breaks mouse resize
        timing = animate.gen_timing.exponential({ duration = 100, unit = 'total' }),
      },
    })
  end,
}

-- alterntaives:
-- https://github.com/luochen1990/rainbow -- 1.7k stars
-- https://github.com/junegunn/rainbow_parentheses.vim -- junegunn, seems "complete", 374 stars
specs.rainbow = {
  'HiPhish/rainbow-delimiters.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  event = 'BufEnter',
}

return u.values(specs)
