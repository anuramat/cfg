return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/nvim-treesitter-context',
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  build = ':TSUpdate', -- without VeryLazy - breaks on first open file with telescope
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    highlight = { enable = true, disable = { 'latex', 'tex' } },
    indent = { enable = true }, -- noexpandtab is broken with python
    ensure_installed = require('plugins.treesitter.core.langs'),
    sync_install = true, -- only applied to `ensure_installed`
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = false,
        node_decremental = '<bs>',
      },
      additional_vim_regex_highlighting = {}, -- use both `:syntax` and Treesitter
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
