local specs = {}
local u = require('utils')

local langs = {
  'bash',
  'c',
  'go',
  'gomod',
  'gosum',
  'gowork',
  'haskell',
  'json',
  'json5',
  'lua',
  'luadoc',
  'luap',
  'markdown',
  'markdown_inline',
  'python',
  'query',
  'regex',
  'sql',
  'vim',
  'vimdoc',
  'yaml',
}

specs.treesitter = {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPre', 'BufNewFile', 'VeryLazy' }, -- without VeryLazy - breaks on first open file with telescope
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
    -- TODO fix ffs
    -- XXX doesn't always work
    -- vim.o.foldmethod = 'expr'
    -- vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
    -- vim.o.foldtext = 'v:lua.vim.treesitter.foldtext()' -- check if supported
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

-- Comments lines
-- alternatively tpope/vim-commentary
specs.comment = {
  'numToStr/Comment.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'JoosepAlviste/nvim-ts-context-commentstring' },
  config = function()
    --- @diagnostic disable-next-line: missing-fields
    require('Comment').setup({
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    })
  end,
  keys = {
    { 'gc', mode = { 'n', 'x' }, desc = 'Comment prefix' },
    { 'gb', mode = { 'n', 'x' }, desc = 'Comment block prefix' },
  },
}

return u.values(specs)
