local specs = {}
local langs = require('plugins.treesitter.langs')
local u = require('utils')

specs.treesitter = {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPre', 'BufNewFile' }, -- without VeryLazy - breaks on first open file with telescope
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/nvim-treesitter-context',
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  opts = {
    highlight = { enable = true, disable = {} },
    indent = { enable = true }, -- noexpandtab is broken with python
    ensure_installed = langs,
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = false,
        node_decremental = '<bs>',
      },
      additional_vim_regex_highlighting = {},
    },
    textobjects = {
      swap = {
        enable = true,
        swap_next = { ['<a-l>'] = '@parameter.inner' },
        swap_previous = { ['<a-h>'] = '@parameter.inner' },
      },
    },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
    require('treesitter-context').setup({
      enable = true,
      max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 20, -- Maximum number of lines to show for a single context
      trim_scope = 'inner', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = 'topline', -- Line used to calculate context. Choices: 'cursor', 'topline'
      -- separator = '―', -- Separator between context and content. nil or a single character
      zindex = 20, -- The Z-index of the context window
    })
    --- @diagnostic disable-next-line: missing-fields
    require('ts_context_commentstring').setup({
      enable_autocmd = false, -- to integrate with numToStr/Comment.nvim
    })
  end,
}

-- Comments lines, post-tpope/vim-commentary
specs.comment = {
  'numToStr/Comment.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'JoosepAlviste/nvim-ts-context-commentstring' },
  config = function()
    --- @diagnostic disable-next-line: missing-fields
    require('Comment').setup({
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      toggler = { line = '<leader>cc', block = '<leader>bb' },
      opleader = { line = '<leader>c', block = '<leader>b' },
      extra = { above = '<leader>cO', below = '<leader>co', eol = '<leader>cA' },
    })
  end,
}

-- symbol outline
specs.aerial = {
  'stevearc/aerial.nvim',
  event = 'BufEnter',
  opts = {
    filter_kind = {
      nix = false,
    },
  },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  keys = { { 'gO', '<cmd>AerialToggle!<cr>', desc = 'Show Aerial Outline' } },
}

return u.values(specs)
