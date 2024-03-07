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
    -- Override shitty default CodeLens style
    local clhl = vim.api.nvim_get_hl(0, { name = 'LspCodeLens' })
    clhl.underline = true
    clhl.bold = true
    vim.api.nvim_set_hl(0, 'LspCodeLens', clhl)
    -- Make window borders properly visible
    vim.cmd('hi WinSeparator guibg=bg guifg=fg')
  end,
}

specs.indentline = {
  'lukas-reineke/indent-blankline.nvim',
  event = 'VeryLazy',
  main = 'ibl',
  opts = {
    exclude = {
      filetypes = {
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

specs.zen = {
  'folke/zen-mode.nvim',
  cmd = 'ZenMode',
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
      alacritty = {
        enabled = true,
        font = '14',
      },
      gitsigns = { enabled = true }, -- hide gitsigns
      tmux = { enabled = true }, -- hide tmux bar BUG can hide bar until tmux restart, careful
    },
  },
}

specs.fidget = {
  'j-hui/fidget.nvim',
  event = 'LspAttach',
  opts = {},
}

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
    })
    return {
      cmdline = { format = { help = false } },
      presets = {
        lsp_doc_border = true, -- add border to hover docs and signature help
        bottom_search = true, -- use a classic bottom cmdline for search
      },
      lsp = {
        signature = { enabled = false, opts = { border = vim.g.border } }, -- overwritten by ray-x/lsp_signature.nvim
        hover = { enabled = false, opts = { border = vim.g.border } },
        override = {
          -- TODO what is this even? it's off by default
          ['vim.lsp.util.convert_input_to_markdown_lines'] = false,
          ['vim.lsp.util.stylize_markdown'] = false,
          ['cmp.entry.get_documentation'] = false, -- requires hrsh7th/nvim-cmp and other two options
        },
      },
      messages = {
        view_search = 'cmdline',
        enabled = false,
      },
    }
  end,
}

specs.signature = {
  'ray-x/lsp_signature.nvim',
  event = 'VeryLazy',
  opts = {
    handler_opts = { border = vim.g.border },
    always_trigger = true,
    -- TODO read README again, it's fucked
  },
  config = function(_, opts)
    require('lsp_signature').setup(opts)
  end,
}

specs.dressing = {
  'stevearc/dressing.nvim',
  opts = {
    input = {
      enabled = false,
    },
  },
  event = 'VeryLazy',
}

specs.aerial = {
  'stevearc/aerial.nvim',
  event = 'BufEnter',
  opts = {
    filter_kind = {
      nix = false,
    },
  },
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  keys = { { 'gO', '<cmd>AerialToggle!<cr>', desc = 'Show Aerial Outline' } },
}

return u.values(specs)
