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
  opts = {},
}

return u.values(specs)
